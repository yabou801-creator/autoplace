import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';

class SellerCardWidget extends StatelessWidget {
  final String sellerName;
  final double sellerRating;
  final int listingCount;
  final bool isOnline;
  final String avatarUrl;
  final String avatarSemanticLabel;
  final bool isAgency;
  final String? agencyStats;
  final String? agencyDescription;

  const SellerCardWidget({
    super.key,
    required this.sellerName,
    required this.sellerRating,
    required this.listingCount,
    required this.isOnline,
    required this.avatarUrl,
    required this.avatarSemanticLabel,
    this.isAgency = false,
    this.agencyStats,
    this.agencyDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: CustomImageWidget(
                      imageUrl: avatarUrl,
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                      semanticLabel: avatarSemanticLabel,
                    ),
                  ),
                  if (isOnline)
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: AppTheme.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            sellerName,
                            style: GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.navy,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (isAgency)
                          Icon(Icons.verified, color: Colors.blue, size: 17),
                        if (!isAgency && isOnline) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.success.withAlpha(26),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'En ligne',
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.success,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    if (isAgency) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withAlpha(20),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Loueur professionnel',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 3),
                          Text(
                            '$sellerRating',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.navy,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$listingCount annonces',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppTheme.mutedText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to seller profile
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Voir le profil',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          if (isAgency && agencyStats != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.people_outline, color: AppTheme.primary, size: 14),
                  const SizedBox(width: 5),
                  Text(
                    agencyStats!,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.navy,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (isAgency && agencyDescription != null) ...[
            const SizedBox(height: 8),
            Text(
              agencyDescription!,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: AppTheme.mutedText,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
