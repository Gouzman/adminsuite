// lib/modules/contracts/contract_form_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractFormPage extends StatefulWidget {
  final String contractType;
  final void Function(String generatedText)? onGenerated;

  const ContractFormPage({
    super.key,
    required this.contractType,
    this.onGenerated,
  });

  @override
  State<ContractFormPage> createState() => _ContractFormPageState();
}

class _ContractFormPageState extends State<ContractFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _counterpartyController = TextEditingController();
  final _durationController = TextEditingController();
  final _amountController = TextEditingController();
  final _obligationsController = TextEditingController();

  bool _isGenerating = false;
  String? _generated;

  @override
  void dispose() {
    _companyController.dispose();
    _counterpartyController.dispose();
    _durationController.dispose();
    _amountController.dispose();
    _obligationsController.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isGenerating = true;
      _generated = null;
    });
    // Ici : appelle ton backend IA / endpoint
    await Future.delayed(const Duration(seconds: 1)); // placeholder
    final generated =
        "Texte du contrat généré (exemple) pour ${widget.contractType}";
    setState(() {
      _isGenerating = false;
      _generated = generated;
    });
    widget.onGenerated?.call(generated);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('contract_form_${"form"}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.contractType,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _companyController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nom de l\'entreprise',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _counterpartyController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nom du client / employé',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        decoration: const InputDecoration(
                          labelText: 'Durée (ex: 12 mois)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Montant / Salaire',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _obligationsController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Obligations principales',
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _isGenerating ? null : _generate,
                      child: _isGenerating
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Générer'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        /* reset */
                      },
                      child: const Text('Réinitialiser'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_generated != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141518),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aperçu généré',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _generated!,
                          style: GoogleFonts.inter(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                /* export PDF */
                              },
                              child: const Text('Télécharger PDF'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
