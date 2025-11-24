import 'package:flutter/material.dart';

class ContractsHomePage extends StatelessWidget {
  const ContractsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0D),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Contrats juridiques IA",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Générez vos contrats professionnels en quelques clics",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 40),

            // Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.4,
                children: [
                  _ContractTypeCard(
                    icon: Icons.assignment,
                    title: "Contrat de prestation",
                    desc:
                        "Création d’un contrat professionnel entre deux parties.",
                    onTap: () {},
                  ),
                  _ContractTypeCard(
                    icon: Icons.work,
                    title: "Contrat de travail",
                    desc: "CDD, CDI, mission, avec clauses personnalisées.",
                    onTap: () {},
                  ),
                  _ContractTypeCard(
                    icon: Icons.shield,
                    title: "NDA - Confidentialité",
                    desc:
                        "Accords de confidentialité pour sécuriser vos échanges.",
                    onTap: () {},
                  ),
                  _ContractTypeCard(
                    icon: Icons.store,
                    title: "Bail commercial",
                    desc: "Contrat de location pour locaux commerciaux.",
                    onTap: () {},
                  ),
                  _ContractTypeCard(
                    icon: Icons.handshake,
                    title: "Partenariat",
                    desc:
                        "Contrats d’accord entre entreprises ou entrepreneurs.",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContractTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final VoidCallback onTap;

  const _ContractTypeCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xFF141518),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0x3300D166), Color(0x1900D166)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(icon, size: 32, color: Colors.white),
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              desc,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
