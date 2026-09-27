import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import './custom_icon_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onCta;

  const EmptyStateWidget({
    super.key,
    required this.iconName,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onCta,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: AppTheme.mutedText,
              size: 72,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.navy,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppTheme.mutedText,
              ),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onCta,
                icon: const Icon(Icons.add_rounded, color: Colors.white),
                label: Text(
                  ctaLabel!,
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  minimumSize: const Size(200, 48),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
