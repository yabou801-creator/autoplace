import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../routes/app_routes.dart';

class OtherListingsWidget extends StatelessWidget {
  OtherListingsWidget({super.key});

  final List<Map<String, dynamic>> _otherListings = [
    {
      'title': 'Toyota Corolla 2019',
      'price': '300 000 DH',
      'city': 'Rabat',
      'imageUrl':
          'https://images.unsplash.com/photo-1675310534327-1bdab1c9ae0f',
      'semanticLabel':
          'White Toyota Corolla sedan parked near palm trees in Rabat',
    },
    {
      'title': 'Kia Sportage 2021',
      'price': '325 000 DH',
      'city': 'Casablanca',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1cf8c2bd8-1779241231320.png',
      'semanticLabel':
          'Gray Kia Sportage SUV parked in urban Casablanca setting',
    },
    {
      'title': 'Renault Clio 2020',
      'price': '195 000 DH',
      'city': 'Marrakech',
      'imageUrl':
          'https://images.unsplash.com/photo-1731707669042-cde6221f5a3b',
      'semanticLabel': 'Red Renault Clio hatchback parked on Marrakech street',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Autres annonces du même vendeur',
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _otherListings.length,
              itemBuilder: (context, index) {
                final item = _otherListings[index];
                return GestureDetector(
                  onTap: () =>
                      context.push(AppRoutes.carDetailScreen, extra: item),
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: CustomImageWidget(
                            imageUrl: item['imageUrl'] as String,
                            width: 140,
                            height: 90,
                            fit: BoxFit.cover,
                            semanticLabel: item['semanticLabel'] as String,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.navy,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['price'] as String,
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primary,
                                ),
                              ),
                              Text(
                                item['city'] as String,
                                style: GoogleFonts.dmSans(
                                  fontSize: 10,
                                  color: AppTheme.mutedText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
