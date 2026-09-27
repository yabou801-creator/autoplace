import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

enum BadgeType { active, sold, rented, archived, new_, occasion }

class StatusBadgeWidget extends StatelessWidget {
  final String label;
  final BadgeType type;
  final double fontSize;

  const StatusBadgeWidget({
    super.key,
    required this.label,
    required this.type,
    this.fontSize = 11,
  });

  Color get _bgColor {
    switch (type) {
      case BadgeType.active:
        return AppTheme.success.withAlpha(31);
      case BadgeType.sold:
        return AppTheme.error.withAlpha(31);
      case BadgeType.rented:
        return AppTheme.primary.withAlpha(31);
      case BadgeType.archived:
        return AppTheme.mutedText.withAlpha(31);
      case BadgeType.new_:
        return AppTheme.primary.withAlpha(31);
      case BadgeType.occasion:
        return AppTheme.warning.withAlpha(31);
    }
  }

  Color get _textColor {
    switch (type) {
      case BadgeType.active:
        return AppTheme.success;
      case BadgeType.sold:
        return AppTheme.error;
      case BadgeType.rented:
        return AppTheme.primary;
      case BadgeType.archived:
        return AppTheme.mutedText;
      case BadgeType.new_:
        return AppTheme.primary;
      case BadgeType.occasion:
        return AppTheme.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: _textColor,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
