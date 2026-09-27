import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/listing_form_widget.dart';
import './widgets/photo_upload_grid_widget.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  final List<String> _uploadedPhotos = [];

  void _onPhotoAdded(String url) {
    if (_uploadedPhotos.length < 8) {
      setState(() => _uploadedPhotos.add(url));
    }
  }

  void _onPhotoRemoved(int index) {
    setState(() => _uploadedPhotos.removeAt(index));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    // TODO: Replace with Supabase insert call to create listing
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => _isSubmitting = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Annonce publiée avec succès !',
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      context.go('/home-feed-screen');
    }
  }

  bool get _isTablet => MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppTheme.navy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Déposer une annonce',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo upload section
                PhotoUploadGridWidget(
                  photos: _uploadedPhotos,
                  onPhotoAdded: _onPhotoAdded,
                  onPhotoRemoved: _onPhotoRemoved,
                  maxPhotos: 8,
                ),
                const SizedBox(height: 16),
                // Form fields
                ListingFormWidget(formKey: _formKey, isTablet: _isTablet),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildSubmitBar(),
    );
  }

  Widget _buildSubmitBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            disabledBackgroundColor: AppTheme.primary.withAlpha(153),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'publish',
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Publier l\'annonce',
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
