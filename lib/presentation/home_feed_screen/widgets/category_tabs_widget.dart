import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class CategoryTabsWidget extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const CategoryTabsWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  static const List<Map<String, String>> _categories = [
    {'key': 'vente', 'label': 'Vente'},
    {'key': 'location', 'label': 'Location'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.navy,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Row(
        children: _categories.map((cat) {
          final isSelected = cat['key'] == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: GestureDetector(
                onTap: () => onCategoryChanged(cat['key']!),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primary
                          : Colors.white.withAlpha(77),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    cat['label']!,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withAlpha(179),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
