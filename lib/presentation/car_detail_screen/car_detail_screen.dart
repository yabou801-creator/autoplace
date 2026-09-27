import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';
import './widgets/car_specs_row_widget.dart';
import './widgets/contact_bottom_bar_widget.dart';
import './widgets/map_section_widget.dart';
import './widgets/other_listings_widget.dart';
import './widgets/photo_gallery_widget.dart';
import './widgets/seller_card_widget.dart';

class CarDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? carData;

  const CarDetailScreen({super.key, this.carData});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  bool _isFavorite = false;
  late Map<String, dynamic> _car;

  static final Map<String, dynamic> _defaultCar = {
    'id': '1',
    'title': 'Dacia Duster',
    'year': '2023',
    'price': '350 000',
    'priceType': 'DH',
    'city': 'Casablanca',
    'seats': 5,
    'fuel': 'Diesel',
    'transmission': 'Automatique',
    'imageUrl':
        'https://img.rocket.new/generatedImages/rocket_gen_img_11b7bea83-1772408042321.png',
    'semanticLabel':
        'White Dacia Duster SUV parked on city street in Casablanca Morocco',
    'isFavorite': false,
    'category': 'vente',
    'condition': 'occasion',
  };

  static final List<Map<String, dynamic>> _galleryImages = [
    {
      'url':
          'https://img.rocket.new/generatedImages/rocket_gen_img_11b7bea83-1772408042321.png',
      'semanticLabel': 'Dacia Duster front view parked on Casablanca street',
    },
    {
      'url': 'https://images.unsplash.com/photo-1714254660860-44418aaca0b4',
      'semanticLabel':
          'Car interior showing steering wheel and dashboard in good condition',
    },
    {
      'url':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1468fa164-1772300767469.png',
      'semanticLabel': 'Rear view of SUV showing clean bodywork and taillights',
    },
    {
      'url':
          'https://img.rocket.new/generatedImages/rocket_gen_img_100ecdcd8-1772654120761.png',
      'semanticLabel':
          'Car side profile showing clean exterior and alloy wheels',
    },
  ];

  @override
  void initState() {
    super.initState();
    _car = widget.carData ?? _defaultCar;
    _isFavorite = (_car['isFavorite'] as bool?) ?? false;
  }

  bool get _isTablet => MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: _isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
    );
  }

  Widget _buildPhoneLayout() {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PhotoGalleryWidget(
                images: _galleryImages,
                onBack: () => context.pop(),
                onFavorite: () => setState(() => _isFavorite = !_isFavorite),
                isFavorite: _isFavorite,
              ),
            ),
            SliverToBoxAdapter(child: _buildMainInfo()),
            SliverToBoxAdapter(
              child: CarSpecsRowWidget(
                city: _car['city'] as String,
                seats: _car['seats'] as int,
                fuel: _car['fuel'] as String,
                transmission: _car['transmission'] as String,
              ),
            ),
            SliverToBoxAdapter(child: _buildDescription()),
            SliverToBoxAdapter(
              child: SellerCardWidget(
                sellerName: 'CTT Location - Rabat',
                sellerRating: 4.9,
                listingCount: 15,
                isOnline: true,
                avatarUrl:
                    'https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=200',
                avatarSemanticLabel:
                    'Professional logo of CTT Location rental agency in Rabat Morocco',
                isAgency: true,
                agencyStats: '120 clients • 15 véhicules',
                agencyDescription:
                    'Agence de location • Rabat, Maroc • Location courte et longue durée • 7j/7',
              ),
            ),
            SliverToBoxAdapter(
              child: MapSectionWidget(city: _car['city'] as String),
            ),
            SliverToBoxAdapter(child: OtherListingsWidget()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ContactBottomBarWidget(
            onWhatsApp: () {
              // TODO: WhatsApp deep link: https://wa.me/212XXXXXXXXX
            },
            onCall: () {
              // TODO: Phone call: tel:+212XXXXXXXXX
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PhotoGalleryWidget(
                    images: _galleryImages,
                    onBack: () => context.pop(),
                    onFavorite: () =>
                        setState(() => _isFavorite = !_isFavorite),
                    isFavorite: _isFavorite,
                  ),
                ),
                SliverToBoxAdapter(child: _buildMainInfo()),
                SliverToBoxAdapter(
                  child: CarSpecsRowWidget(
                    city: _car['city'] as String,
                    seats: _car['seats'] as int,
                    fuel: _car['fuel'] as String,
                    transmission: _car['transmission'] as String,
                  ),
                ),
                SliverToBoxAdapter(child: _buildDescription()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SellerCardWidget(
                    sellerName: 'CTT Location - Rabat',
                    sellerRating: 4.9,
                    listingCount: 15,
                    isOnline: true,
                    avatarUrl:
                        'https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=200',
                    avatarSemanticLabel:
                        'Professional logo of CTT Location rental agency in Rabat Morocco',
                    isAgency: true,
                    agencyStats: '120 clients • 15 véhicules',
                    agencyDescription:
                        'Agence de location • Rabat, Maroc • Location courte et longue durée • 7j/7',
                  ),
                  MapSectionWidget(city: _car['city'] as String),
                  ContactBottomBarWidget(
                    onWhatsApp: () {},
                    onCall: () {},
                    isEmbedded: true,
                  ),
                  OtherListingsWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_car['title']} ${_car['year']}',
                      style: GoogleFonts.dmSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.navy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${_car['price']} ${_car['priceType']}',
                          style: GoogleFonts.dmSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: (_car['condition'] == 'neuve')
                      ? AppTheme.primary.withAlpha(26)
                      : AppTheme.warning.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (_car['condition'] == 'neuve') ? 'Neuve' : 'Occasion',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: (_car['condition'] == 'neuve')
                        ? AppTheme.primary
                        : AppTheme.warning,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Voiture en excellent état, bien entretenue. Idéale pour la ville et les longs trajets. Climatisation, caméra de recul, GPS, vitres électriques. Carnet d\'entretien à jour. Première main, non accidentée. Disponible immédiatement à Casablanca.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: const Color(0xFF334155),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
