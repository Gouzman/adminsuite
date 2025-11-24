// lib/modules/contracts/contract_preview_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractPreviewPage extends StatelessWidget {
  final String title;
  final String content;
  const ContractPreviewPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('contract_preview'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
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
                  /* download pdf */
                },
                child: const Text('Télécharger PDF'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  /* edit */
                },
                child: const Text('Modifier'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
