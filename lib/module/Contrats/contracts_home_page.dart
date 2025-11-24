import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef OpenFormCallback = void Function(String contractType);

class ContractsHomePage extends StatelessWidget {
  final OpenFormCallback? onOpenForm;
  const ContractsHomePage({super.key, this.onOpenForm});

  @override
  Widget build(BuildContext context) {
    final types = [
      {'label': 'Contrat de prestation', 'icon': Icons.description},
      {'label': 'Contrat de travail', 'icon': Icons.work},
      {'label': 'NDA - Confidentialité', 'icon': Icons.lock},
      {'label': 'Bail commercial', 'icon': Icons.store},
      {'label': 'Convention de partenariat', 'icon': Icons.handshake},
    ];

    return SingleChildScrollView(
      key: const ValueKey('contracts_home_scroll'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contrats juridiques IA',
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choisissez un type de contrat pour démarrer',
            style: GoogleFonts.inter(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: types.map((t) {
              return SizedBox(
                width: 320,
                child: Card(
                  color: const Color(0xFF141518),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => (onOpenForm ?? (_) {})(t['label'] as String),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              t['icon'] as IconData,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t['label'] as String,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Générez rapidement ce type de contrat',
                                  style: GoogleFonts.inter(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
