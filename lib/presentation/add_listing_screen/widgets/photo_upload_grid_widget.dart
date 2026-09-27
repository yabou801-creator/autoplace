import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';

class PhotoUploadGridWidget extends StatelessWidget {
  final List<String> photos;
  final ValueChanged<String> onPhotoAdded;
  final ValueChanged<int> onPhotoRemoved;
  final int maxPhotos;

  const PhotoUploadGridWidget({
    super.key,
    required this.photos,
    required this.onPhotoAdded,
    required this.onPhotoRemoved,
    this.maxPhotos = 8,
  });

  // Mock photo URLs for demo purposes
  static const List<String> _demoPhotos = [
    'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg?auto=compress&cs=tinysrgb&w=400',
    'https://images.pixabay.com/photo/2018/02/21/03/15/peugeot-3388864_1280.jpg',
    'https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?w=400&auto=format&fit=crop',
  ];

  static const List<String> _demoSemanticLabels = [
    'White SUV front view for car listing photo upload',
    'Silver crossover side view for car listing',
    'Red hatchback rear view for car listing photo',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'photo_camera',
                color: AppTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Ajouter des photos',
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
              const Spacer(),
              Text(
                '${photos.length}/$maxPhotos',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: AppTheme.mutedText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Jusqu\'à $maxPhotos photos',
            style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.mutedText),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: maxPhotos,
            itemBuilder: (context, index) {
              if (index < photos.length) {
                return _buildPhotoSlot(context, index, photos[index]);
              }
              return _buildEmptySlot(context, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSlot(BuildContext context, int index, String imageUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CustomImageWidget(
            imageUrl: imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            semanticLabel: 'Uploaded car photo ${index + 1} for new listing',
          ),
        ),
        if (index == 0)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                'Principale',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        Positioned(
          top: 3,
          right: 3,
          child: GestureDetector(
            onTap: () => onPhotoRemoved(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppTheme.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySlot(BuildContext context, int index) {
    final isNextSlot = index == photos.length;
    return GestureDetector(
      onTap: isNextSlot
          ? () {
              // TODO: Implement image_picker for real photo upload
              // For demo: cycle through demo photos
              final demoIndex = photos.length % _demoPhotos.length;
              onPhotoAdded(_demoPhotos[demoIndex]);
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: isNextSlot
              ? AppTheme.primary.withAlpha(10)
              : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isNextSlot ? AppTheme.primary : AppTheme.borderColor,
            width: isNextSlot ? 1.5 : 1,
            style: BorderStyle.solid,
          ),
        ),
        child: isNextSlot
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'add_photo_alternate',
                    color: AppTheme.primary,
                    size: 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Ajouter',
                    style: GoogleFonts.dmSans(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              )
            : CustomIconWidget(
                iconName: 'image_outlined',
                color: AppTheme.borderColor,
                size: 20,
              ),
      ),
    );
  }
}
