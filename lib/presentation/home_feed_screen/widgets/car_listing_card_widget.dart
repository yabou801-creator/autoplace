import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../home_feed_screen.dart';

class CarListingCardWidget extends StatefulWidget {
  final CarListing car;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onCallTap;

  const CarListingCardWidget({
    super.key,
    required this.car,
    required this.onTap,
    required this.onFavoriteTap,
    required this.onWhatsAppTap,
    required this.onCallTap,
  });

  @override
  State<CarListingCardWidget> createState() => _CarListingCardWidgetState();
}

class _CarListingCardWidgetState extends State<CarListingCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heartScale = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
      ],
    ).animate(CurvedAnimation(parent: _heartController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleFavorite() {
    _heartController.forward(from: 0);
    widget.onFavoriteTap();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('car-${widget.car.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete_outline, color: Colors.white, size: 28),
            const SizedBox(height: 4),
            Text(
              'Supprimer',
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        // TODO: Implement delete listing API call
        return false;
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(
                color: widget.car.isFavorite
                    ? AppTheme.primary
                    : Colors.transparent,
                width: 3,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(18),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(),
              _buildInfoSection(),
              _buildActionRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Hero(
            tag: 'car-image-${widget.car.id}',
            child: CustomImageWidget(
              imageUrl: widget.car.imageUrl,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
              semanticLabel: widget.car.semanticLabel,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: _handleFavorite,
            child: ScaleTransition(
              scale: _heartScale,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(38), blurRadius: 6),
                  ],
                ),
                child: Icon(
                  widget.car.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.car.isFavorite
                      ? Colors.red
                      : AppTheme.mutedText,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.car.condition == 'neuve'
                  ? AppTheme.primary
                  : AppTheme.navy,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.car.condition == 'neuve' ? 'Neuve' : 'Occasion',
              style: GoogleFonts.dmSans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${widget.car.title} ${widget.car.year}',
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.navy,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.car.price} ${widget.car.priceType}',
            style: GoogleFonts.dmSans(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          if (widget.car.agencyName.isNotEmpty) ...[
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.business, color: AppTheme.primary, size: 12),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${widget.car.title} ${widget.car.year} - ${widget.car.agencyName} • ${widget.car.transmission} • ${widget.car.seats} places',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.mutedText,
                size: 13,
              ),
              const SizedBox(width: 3),
              Text(
                widget.car.city,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: AppTheme.mutedText,
                ),
              ),
              const SizedBox(width: 12),
              CustomIconWidget(
                iconName: 'people',
                color: AppTheme.mutedText,
                size: 13,
              ),
              const SizedBox(width: 3),
              Text(
                '${widget.car.seats} places',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: AppTheme.mutedText,
                ),
              ),
              const SizedBox(width: 12),
              _specChip(widget.car.fuel),
              const SizedBox(width: 6),
              _specChip(widget.car.transmission),
            ],
          ),
        ],
      ),
    );
  }

  Widget _specChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppTheme.navy,
        ),
      ),
    );
  }

  Widget _buildActionRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.onWhatsAppTap,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.whatsappGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.chat, color: Colors.white, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      'WhatsApp',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: widget.onCallTap,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: Colors.white, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      'Appeler',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
