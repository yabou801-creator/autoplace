import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';

class PhotoGalleryWidget extends StatefulWidget {
  final List<Map<String, dynamic>> images;
  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const PhotoGalleryWidget({
    super.key,
    required this.images,
    required this.onBack,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  State<PhotoGalleryWidget> createState() => _PhotoGalleryWidgetState();
}

class _PhotoGalleryWidgetState extends State<PhotoGalleryWidget> {
  // TODO: Replace with [Riverpod/Bloc] for production
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final img = widget.images[index];
              return CustomImageWidget(
                imageUrl: img['url'] as String,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                semanticLabel: img['semanticLabel'] as String,
              );
            },
          ),
        ),
        // Back button
        Positioned(
          top: 48,
          left: 16,
          child: GestureDetector(
            onTap: widget.onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        // Favorite button
        Positioned(
          top: 48,
          right: 16,
          child: GestureDetector(
            onTap: widget.onFavorite,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? Colors.red : Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        // Counter indicator
        Positioned(
          bottom: 12,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(153),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_currentIndex + 1}/${widget.images.length}',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Dot indicators
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.images.length, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _currentIndex ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _currentIndex
                      ? AppTheme.primary
                      : Colors.white.withAlpha(153),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
