import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/car_listing_card_widget.dart';
import './widgets/category_tabs_widget.dart';
import './widgets/hero_banner_widget.dart';
import './widgets/search_bar_widget.dart';

class CarListing {
  final String id;
  final String title;
  final String year;
  final String price;
  final String priceType;
  final String city;
  final int seats;
  final String fuel;
  final String transmission;
  final String imageUrl;
  final String semanticLabel;
  final bool isFavorite;
  final String category; // vente, achat, location
  final String condition; // neuve, occasion
  final String agencyName;

  CarListing({
    required this.id,
    required this.title,
    required this.year,
    required this.price,
    required this.priceType,
    required this.city,
    required this.seats,
    required this.fuel,
    required this.transmission,
    required this.imageUrl,
    required this.semanticLabel,
    required this.isFavorite,
    required this.category,
    required this.condition,
    this.agencyName = '',
  });

  factory CarListing.fromMap(Map<String, dynamic> map) {
    return CarListing(
      id: map['id'] as String,
      title: map['title'] as String,
      year: map['year'] as String,
      price: map['price'] as String,
      priceType: map['priceType'] as String,
      city: map['city'] as String,
      seats: map['seats'] as int,
      fuel: map['fuel'] as String,
      transmission: map['transmission'] as String,
      imageUrl: map['imageUrl'] as String,
      semanticLabel: map['semanticLabel'] as String,
      isFavorite: map['isFavorite'] as bool,
      category: map['category'] as String,
      condition: map['condition'] as String,
      agencyName: (map['agencyName'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'year': year,
    'price': price,
    'priceType': priceType,
    'city': city,
    'seats': seats,
    'fuel': fuel,
    'transmission': transmission,
    'imageUrl': imageUrl,
    'semanticLabel': semanticLabel,
    'isFavorite': isFavorite,
    'category': category,
    'condition': condition,
    'agencyName': agencyName,
  };

  CarListing copyWith({bool? isFavorite}) => CarListing(
    id: id,
    title: title,
    year: year,
    price: price,
    priceType: priceType,
    city: city,
    seats: seats,
    fuel: fuel,
    transmission: transmission,
    imageUrl: imageUrl,
    semanticLabel: semanticLabel,
    isFavorite: isFavorite ?? this.isFavorite,
    category: category,
    condition: condition,
    agencyName: agencyName,
  );
}

final List<Map<String, dynamic>> _mockListingMaps = [
  {
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
    'agencyName': 'Casa Rent Car',
  },
  {
    'id': '2',
    'title': 'Peugeot 3008',
    'year': '2022',
    'price': '400 000',
    'priceType': 'DH',
    'city': 'Rabat',
    'seats': 5,
    'fuel': 'Essence',
    'transmission': 'Automatique',
    'imageUrl': 'https://images.unsplash.com/photo-1727893344848-2ec8eba4bacd',
    'semanticLabel': 'Silver Peugeot 3008 crossover SUV on display in showroom',
    'isFavorite': true,
    'category': 'vente',
    'condition': 'occasion',
    'agencyName': 'Bureau de Location Walid - Rabat',
  },
  {
    'id': '3',
    'title': 'Renault Clio',
    'year': '2021',
    'price': '220 000',
    'priceType': 'DH',
    'city': 'Tanger',
    'seats': 5,
    'fuel': 'Essence',
    'transmission': 'Manuelle',
    'imageUrl': 'https://images.unsplash.com/photo-1648049890428-7c8519dff721',
    'semanticLabel':
        'Red Renault Clio hatchback parked in front of white building',
    'isFavorite': false,
    'category': 'vente',
    'condition': 'occasion',
    'agencyName': 'Rabat Auto Loc',
  },
  {
    'id': '4',
    'title': 'Hyundai i10',
    'year': '2023',
    'price': '180 000',
    'priceType': 'DH',
    'city': 'Fès',
    'seats': 5,
    'fuel': 'Essence',
    'transmission': 'Manuelle',
    'imageUrl':
        'https://img.rocket.new/generatedImages/rocket_gen_img_10271f9fd-1768370737312.png',
    'semanticLabel':
        'Blue Hyundai i10 compact city car on mountain road in Morocco',
    'isFavorite': false,
    'category': 'vente',
    'condition': 'neuve',
    'agencyName': 'Express Location - Temara',
  },
  {
    'id': '5',
    'title': 'Toyota Corolla',
    'year': '2022',
    'price': '1 200',
    'priceType': 'DH/jour',
    'city': 'Marrakech',
    'seats': 5,
    'fuel': 'Essence',
    'transmission': 'Automatique',
    'imageUrl': 'https://images.unsplash.com/photo-1732260089180-8f3fb6498e30',
    'semanticLabel':
        'White Toyota Corolla sedan parked near palm trees in Marrakech',
    'isFavorite': false,
    'category': 'location',
    'condition': 'neuve',
    'agencyName': 'CTT Location - Rabat',
  },
  {
    'id': '6',
    'title': 'Kia Sportage',
    'year': '2021',
    'price': '310 000',
    'priceType': 'DH',
    'city': 'Casablanca',
    'seats': 5,
    'fuel': 'Diesel',
    'transmission': 'Automatique',
    'imageUrl':
        'https://img.rocket.new/generatedImages/rocket_gen_img_11b7bea83-1772408042321.png',
    'semanticLabel': 'Gray Kia Sportage SUV driving on highway near Casablanca',
    'isFavorite': false,
    'category': 'vente',
    'condition': 'occasion',
    'agencyName': 'Casa Rent Car',
  },
  {
    'id': '7',
    'title': 'Volkswagen Golf',
    'year': '2020',
    'price': '260 000',
    'priceType': 'DH',
    'city': 'Rabat',
    'seats': 5,
    'fuel': 'Diesel',
    'transmission': 'Manuelle',
    'imageUrl': 'https://images.unsplash.com/photo-1651110920535-537855f35036',
    'semanticLabel':
        'Dark blue Volkswagen Golf hatchback on city street at dusk',
    'isFavorite': false,
    'category': 'vente',
    'condition': 'occasion',
    'agencyName': 'Bureau de Location Walid - Rabat',
  },
  {
    'id': '8',
    'title': 'Ford Ranger',
    'year': '2023',
    'price': '2 500',
    'priceType': 'DH/jour',
    'city': 'Agadir',
    'seats': 5,
    'fuel': 'Diesel',
    'transmission': 'Automatique',
    'imageUrl': 'https://images.unsplash.com/photo-1544601640-b256c49a192d',
    'semanticLabel':
        'White Ford Ranger pickup truck on desert road near Agadir',
    'isFavorite': false,
    'category': 'location',
    'condition': 'neuve',
    'agencyName': 'Express Location - Temara',
  },
];

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen>
    with TickerProviderStateMixin {
  // TODO: Replace with [Riverpod/Bloc] for production
  late List<CarListing> _allListings;
  late List<CarListing> _filteredListings;
  String _selectedCategory = 'vente';
  String _searchQuery = '';
  bool _isLoading = false;

  late AnimationController _listAnimController;

  @override
  void initState() {
    super.initState();
    _allListings = _mockListingMaps.map(CarListing.fromMap).toList();
    _filteredListings = _allListings
        .where((l) => l.category == _selectedCategory)
        .toList();

    _listAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _listAnimController.forward();
  }

  @override
  void dispose() {
    _listAnimController.dispose();
    super.dispose();
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      _applyFilters();
    });
    _listAnimController.reset();
    _listAnimController.forward();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _applyFilters() {
    _filteredListings = _allListings.where((l) {
      final matchesCategory = l.category == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          l.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          l.city.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _toggleFavorite(String id) {
    setState(() {
      final index = _allListings.indexWhere((l) => l.id == id);
      if (index != -1) {
        _allListings[index] = _allListings[index].copyWith(
          isFavorite: !_allListings[index].isFavorite,
        );
      }
      _applyFilters();
    });
  }

  void _onCarTap(CarListing car) {
    context.push(AppRoutes.carDetailScreen, extra: car.toMap());
  }

  bool get _isTablet => MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppTheme.primary,
          onRefresh: () async {
            setState(() => _isLoading = true);
            await Future.delayed(const Duration(milliseconds: 800));
            // TODO: Replace with real API call to fetch listings
            setState(() => _isLoading = false);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(
                child: CategoryTabsWidget(
                  selectedCategory: _selectedCategory,
                  onCategoryChanged: _onCategoryChanged,
                ),
              ),
              SliverToBoxAdapter(
                child: HeroBannerWidget(
                  onDeposerTap: () => context.go(AppRoutes.addListingScreen),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Annonces récentes',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.navy,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Voir tout >',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isLoading)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => const CarCardSkeletonWidget(),
                    childCount: 4,
                  ),
                )
              else if (_filteredListings.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'directions_car',
                          color: AppTheme.mutedText,
                          size: 64,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Aucune annonce trouvée',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.navy,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Modifiez vos critères de recherche',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: AppTheme.mutedText,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (_isTablet)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final car = _filteredListings[index];
                      return _buildAnimatedCard(index, car);
                    }, childCount: _filteredListings.length),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final car = _filteredListings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: _buildAnimatedCard(index, car),
                      );
                    }, childCount: _filteredListings.length),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(int index, CarListing car) {
    final delay = (index * 80).clamp(0, 400);
    return AnimatedBuilder(
      animation: _listAnimController,
      builder: (context, child) {
        final delayedValue =
            (((_listAnimController.value * 600) - delay) / 200.0).clamp(
              0.0,
              1.0,
            );
        return Opacity(
          opacity: delayedValue,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - delayedValue)),
            child: child,
          ),
        );
      },
      child: CarListingCardWidget(
        car: car,
        onTap: () => _onCarTap(car),
        onFavoriteTap: () => _toggleFavorite(car.id),
        onWhatsAppTap: () {
          // TODO: Implement WhatsApp deep link: wa.me/212XXXXXXXXX
        },
        onCallTap: () {
          // TODO: Implement phone call: tel:+212XXXXXXXXX
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.navy, AppTheme.navyLight],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.directions_car,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'AutoPlace',
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          SearchBarWidget(onChanged: _onSearchChanged),
        ],
      ),
    );
  }
}

// Re-export skeleton for use in this file
class CarCardSkeletonWidget extends StatelessWidget {
  const CarCardSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
