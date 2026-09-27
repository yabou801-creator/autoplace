import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class CarSpecsRowWidget extends StatelessWidget {
  final String city;
  final int seats;
  final String fuel;
  final String transmission;

  const CarSpecsRowWidget({
    super.key,
    required this.city,
    required this.seats,
    required this.fuel,
    required this.transmission,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 14),
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
      child: Row(
        children: [
          _specItem('location_on', city, 'Ville'),
          _divider(),
          _specItem('people', '$seats places', 'Places'),
          _divider(),
          _specItem(
            fuel == 'Diesel' ? 'local_gas_station' : 'speed',
            fuel,
            'Carburant',
          ),
          _divider(),
          _specItem('settings', transmission, 'Boîte'),
        ],
      ),
    );
  }

  Widget _specItem(String iconName, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.primary,
            size: 22,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.navy,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: GoogleFonts.dmSans(fontSize: 10, color: AppTheme.mutedText),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 40, color: AppTheme.borderColor);
  }
}
