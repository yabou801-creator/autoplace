import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchBarWidget({super.key, required this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          CustomIconWidget(
            iconName: 'search',
            color: AppTheme.mutedText,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
              decoration: InputDecoration(
                hintText: 'Rechercher une voiture...',
                hintStyle: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppTheme.mutedText,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Container(width: 1, height: 24, color: AppTheme.borderColor),
          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomIconWidget(
                iconName: 'tune',
                color: AppTheme.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
