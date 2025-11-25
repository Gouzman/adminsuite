// lib/modules/contracts/contract_form_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef GeneratedCallback = void Function(String generatedText, String? title);
typedef VoidCallbackSimple = void Function();

class ContractFormPage extends StatefulWidget {
  final String contractType;
  final GeneratedCallback? onGenerated;
  final VoidCallbackSimple? onBack;

  const ContractFormPage({
    super.key,
    required this.contractType,
    this.onGenerated,
    this.onBack,
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
    // --- MOCK IA ---
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    final title =
        '${widget.contractType} - ${_companyController.text.isNotEmpty ? _companyController.text : 'Société'}';
    final generated =
        '''
Titre: $title

Entre: ${_companyController.text}
Et: ${_counterpartyController.text}

Durée: ${_durationController.text}
Montant: ${_amountController.text}

Obligations:
${_obligationsController.text}

--- Clauses standards ---
1) Objet...
2) Durée...
3) Confidentialité...
    ''';
    setState(() {
      _isGenerating = false;
      _generated = generated;
    });
    // notify parent (dashboard) to open preview
    widget.onGenerated?.call(generated, title);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: ValueKey('contract_form_${widget.contractType}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back),
                color: Colors.white70,
              ),
              const SizedBox(width: 8),
              Text(
                widget.contractType,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _companyController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nom de l\'entreprise',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF0F1315),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatoire' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _counterpartyController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nom du client / employé',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF0F1315),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatoire' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Durée (ex: 12 mois)',
                          labelStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: const Color(0xFF0F1315),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Montant / Salaire',
                          labelStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: const Color(0xFF0F1315),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _obligationsController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Obligations principales',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF0F1315),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _isGenerating ? null : _generate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D166),
                      ),
                      child: _isGenerating
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Générer'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
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
                          'Aperçu (local)',
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
                                /* export PDF local */
                              },
                              child: const Text('Télécharger PDF'),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () {
                                /* copy to clipboard */
                              },
                              child: const Text('Copier'),
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
