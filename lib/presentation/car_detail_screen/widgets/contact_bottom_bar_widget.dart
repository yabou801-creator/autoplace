import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class ContactBottomBarWidget extends StatelessWidget {
  final VoidCallback onWhatsApp;
  final VoidCallback onCall;
  final bool isEmbedded;

  const ContactBottomBarWidget({
    super.key,
    required this.onWhatsApp,
    required this.onCall,
    this.isEmbedded = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        isEmbedded ? 12 : MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: isEmbedded
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
        borderRadius: isEmbedded
            ? BorderRadius.circular(14)
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onWhatsApp,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.whatsappGreen,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.whatsappGreen.withAlpha(77),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chat_bubble,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'WhatsApp',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onCall,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(77),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Appeler',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
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

    if (isEmbedded) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: content,
      );
    }
    return content;
  }
}
