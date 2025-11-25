// lib/modules/contracts/contract_preview_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef VoidCallbackSimple = void Function();

class ContractPreviewPage extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallbackSimple? onEdit;
  final VoidCallbackSimple? onBack;

  const ContractPreviewPage({
    super.key,
    required this.title,
    required this.content,
    this.onEdit,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('contract_preview'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                color: Colors.white70,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF141518),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: GoogleFonts.inter(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: export PDF (we will add implementation)
                  // For now mock: show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Téléchargement PDF (mock)')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D166),
                ),
                child: const Text('Télécharger PDF'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(onPressed: onEdit, child: const Text('Modifier')),
            ],
          ),
        ],
      ),
    );
  }
}
