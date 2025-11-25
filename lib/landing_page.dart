// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app/dashboard/dashboard_page.dart';

void main() {
  runApp(const AdminsuiteApp());
}

/* ---------------- DESIGN SYSTEM CONSTANTS ---------------- */
class DS {
  // Colors
  static const Color bgPrimary = Color(0xFF0A0B0D);
  static const Color bgSecondary = Color(0xFF141518);
  static const Color bgTertiary = Color(0xFF1A1B1F);

  static const Color borderSubtle = Color(0xFF1F2024);
  static const Color borderBright = Color.fromRGBO(255, 255, 255, 0.1);

  static const Color accentPrimary = Color(0xFF00D166);
  static const Color accentLight = Color(0xFF00F580);
  static const Color accentDark = Color(0xFF00B857);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE5E7EB);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // Couleurs pour la bannière et dégradés
  static const Color darkGreen = Color(0xFF006633);
  static const LinearGradient greenGradient = LinearGradient(
    colors: [DS.accentPrimary, DS.darkGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const double bannerHeight = 60.0;

  // Spacing
  static const double s1 = 8;
  static const double s2 = 16;
  static const double s3 = 24;
  static const double s4 = 32;
  static const double s5 = 48;
  static const double sectionGap = 100;
  static const double sectionPaddingDesktop = 120;
  static const double sectionPaddingMobile = 80;

  // Radii
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  // Shadows
  static final List<BoxShadow> glowMd = [
    BoxShadow(
      color: DS.accentPrimary.withValues(alpha: 0.2),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  // Breakpoints
  static const double mobileMax = 767;
  static const double tabletMax = 1023;
}

/* ---------------- APP ---------------- */
class AdminsuiteApp extends StatelessWidget {
  const AdminsuiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData.dark().textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adminsuite',
      theme: ThemeData(
        scaffoldBackgroundColor: DS.bgPrimary,
        textTheme: GoogleFonts.interTextTheme(
          textTheme,
        ).apply(bodyColor: DS.textSecondary, displayColor: DS.textPrimary),
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: DS.accentPrimary,
          surface: DS.bgPrimary,
          surfaceContainerHighest: DS.bgSecondary,
        ),
      ),
      home: const LandingPage(),
    );
  }
}

/* ---------------- GRID PAINTER ---------------- */
class GridPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  GridPatternPainter({
    this.color = const Color(0xFF1F2024),
    this.spacing = 40.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/* ---------------- LANDING PAGE ---------------- */
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= DS.mobileMax;
    final sectionPadding = isMobile
        ? DS.sectionPaddingMobile
        : DS.sectionPaddingDesktop;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER AREA AVEC FOND QUADRILLÉ ---
            Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: DS.bgPrimary,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 800,
                            height: 800,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  DS.accentPrimary.withValues(alpha: 0.08),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.7],
                              ),
                            ),
                          ),
                        ),
                        CustomPaint(
                          size: Size(width, 900),
                          painter: GridPatternPainter(
                            color: Colors.white.withValues(alpha: 0.03),
                            spacing: 50,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  DS.bgPrimary.withValues(alpha: 0.0),
                                  DS.bgPrimary,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    const SizedBox(height: 12),
                    TopNav(
                      onCta: () => _launchUrl('https://adminsuite.example.com'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: sectionPadding,
                        horizontal: _horizontalPadding(width),
                      ),
                      child: _Hero(width: width),
                    ),
                  ],
                ),
              ],
            ),

            // Partners strip
            const PartnersStrip(),

            const SizedBox(height: 100),

            // Value
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const ValueSection(),
            ),

            const SizedBox(height: 80),

            // Features grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const FeaturesGrid(),
            ),

            const SizedBox(height: 120),

            // Key Values Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const KeyValuesSection(),
            ),

            const SizedBox(height: 120),

            // --- NOUVEAU : TÉMOIGNAGES ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const TestimonialsSection(),
            ),

            const SizedBox(height: 120),

            // How it works
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const HowItWorksSection(),
            ),

            const SizedBox(height: 120),

            // Pricing
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const PricingSection(),
            ),

            const SizedBox(height: 120),

            // --- NOUVEAU : FAQ ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const FaqSection(),
            ),

            const SizedBox(height: 120),

            // CTA
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const FinalCta(),
            ),

            const SizedBox(height: 60),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }

  static double _horizontalPadding(double width) {
    if (width <= DS.mobileMax) return 24;
    if (width <= DS.tabletMax) return 48;
    return 120;
  }
}

/* ---------------- TOP NAV ---------------- */
class TopNav extends StatelessWidget {
  final VoidCallback onCta;
  const TopNav({required this.onCta, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= DS.mobileMax;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: 12,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          // logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [DS.accentPrimary, DS.accentLight],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shield, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Adminsuite',
                style: TextStyle(
                  color: DS.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (!isMobile)
            Row(
              children: [
                _NavText('Accueil'),
                _NavText('Fonctionnalités'),
                _NavText('Tarifs'),
                _NavText('Ressources'),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onCta,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: DS.accentPrimary,
                    elevation: 6,
                    shadowColor: DS.accentPrimary.withValues(alpha: 0.3),
                  ),
                  child: const Text(
                    'Essai gratuit',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            )
          else
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menu mobile (à implémenter)')),
                );
              },
              icon: const Icon(Icons.menu),
              color: DS.textTertiary,
            ),
        ],
      ),
    );
  }
}

class _NavText extends StatelessWidget {
  final String text;
  const _NavText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: DS.textTertiary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/* ---------------- HERO ---------------- */
class _Hero extends StatelessWidget {
  final double width;
  const _Hero({required this.width});

  @override
  Widget build(BuildContext context) {
    final isWide = width > 1000;

    // Contenu Texte (Gauche)
    final leftContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: DS.accentPrimary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.public, size: 16, color: DS.accentPrimary),
              SizedBox(width: 8),
              Text(
                'Conçu pour l\'Afrique',
                style: TextStyle(
                  color: DS.accentPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DS.s3),
        Text(
          'Gérez votre administratif\navec l’intelligence artificielle.',
          style: TextStyle(
            fontSize: _heroTitleSize(width),
            height: _heroLineHeight(width) / _heroTitleSize(width),
            fontWeight: FontWeight.w700,
            color: DS.textPrimary,
          ),
        ),
        const SizedBox(height: DS.s3),
        Text(
          'Créez des offres, contrats et factures en quelques secondes — optimisé pour les entrepreneurs et PME d’Afrique francophone.',
          style: const TextStyle(
            fontSize: 18,
            color: DS.textTertiary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: DS.s3),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ContractFormPage(contractType: "Général"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                backgroundColor: DS.accentPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                shadowColor: DS.accentPrimary.withValues(alpha: 0.25),
              ),
              child: const Text(
                'Démarrer gratuitement',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: DS.s2),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ContractFormPage(contractType: "Général"),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                side: BorderSide(color: DS.borderBright),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Voir une démo',
                style: TextStyle(color: DS.textSecondary),
              ),
            ),
          ],
        ),
      ],
    );

    // Contenu Visuel (Droite)
    final rightContent = Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Dashboard.png',
              width: 800,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: DS.borderSubtle),
                  ),
                  child: const Center(child: Text("Image Dashboard")),
                );
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 40,
            child: _MiniFloatingCard(
              title: 'Facture générée ✓',
              width: 180,
              height: 80,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 30,
            child: _MiniFloatingCard(
              title: 'Contrat signé ✓',
              width: 160,
              height: 80,
            ),
          ),
        ],
      ),
    );

    // LOGIQUE DE RESPONSIVE
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: leftContent),
          const SizedBox(width: 28),
          Expanded(flex: 5, child: rightContent),
        ],
      );
    } else {
      return Column(
        children: [
          leftContent,
          const SizedBox(height: 40),
          SizedBox(height: 400, child: rightContent),
        ],
      );
    }
  }

  static double _heroTitleSize(double width) {
    if (width <= DS.mobileMax) return 40;
    if (width <= DS.tabletMax) return 56;
    return 72;
  }

  static double _heroLineHeight(double width) {
    if (width <= DS.mobileMax) return 48;
    if (width <= DS.tabletMax) return 64;
    return 80;
  }
}

class _MiniFloatingCard extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  const _MiniFloatingCard({
    required this.title,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DS.bgSecondary.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DS.borderBright),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: DS.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.check_circle, color: DS.accentPrimary, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text('Succès', style: TextStyle(color: DS.textTertiary)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ---------------- PARTNERS STRIP ---------------- */
class PartnersStrip extends StatelessWidget {
  const PartnersStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final showAllPartners = width > DS.mobileMax;

    return Column(
      children: [
        const Text(
          'Déjà utilisé par des entrepreneurs et PME en Afrique francophone',
          style: TextStyle(color: DS.textTertiary),
        ),
        const SizedBox(height: 40),

        SizedBox(
          height: 120,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // 1. Glow vert
              Positioned(
                top: 25,
                child: Container(
                  height: DS.bannerHeight,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: DS.darkGreen.withValues(alpha: 0.6),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              // 2. Bande verte arrière (Inclinée)
              Transform.rotate(
                angle: -0.03,
                child: Container(
                  height: DS.bannerHeight + 8,
                  width: double.infinity,
                  color: DS.darkGreen,
                ),
              ),
              // 3. Bande verte avant (Droite + Gradient)
              Container(
                height: DS.bannerHeight,
                width: double.infinity,
                decoration: const BoxDecoration(gradient: DS.greenGradient),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _PartnerItem("PARTENAIRE 1"),
                    const _StarItem(),
                    const _PartnerItem("PARTENAIRE 2"),
                    const _StarItem(),
                    const _PartnerItem("PARTENAIRE 3"),
                    if (showAllPartners) ...[
                      const _StarItem(),
                      const _PartnerItem("PARTENAIRE 4"),
                      const _StarItem(),
                      const _PartnerItem("PARTENAIRE 5"),
                      const _StarItem(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PartnerItem extends StatelessWidget {
  final String text;
  const _PartnerItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
        fontFamily: 'Arial',
      ),
    );
  }
}

class _StarItem extends StatelessWidget {
  const _StarItem();
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.emergency, color: Colors.white, size: 20);
  }
}

/* ---------------- VALUE SECTION ---------------- */
class ValueSection extends StatelessWidget {
  const ValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Le tout-en-un administratif pour entrepreneurs modernes',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: DS.textPrimary,
          ),
        ),
        SizedBox(height: DS.s2),
        SizedBox(
          width: 820,
          child: Text(
            'Optimisez votre temps grâce à l’IA. Rédigez, signez et automatisez vos documents sans stress et sans erreur.',
            textAlign: TextAlign.center,
            style: TextStyle(color: DS.textTertiary),
          ),
        ),
      ],
    );
  }
}

/* ---------------- FEATURES GRID ---------------- */
class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width > 1100 ? 3 : (width > 800 ? 2 : 1);
    return GridView.count(
      crossAxisCount: crossAxis,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 320 / 170,
      children: const [
        RectFeatureTile(
          title: 'Recrutement IA',
          subtitle: 'Générez offres, tests techniques et guides d’entretien.',
          icon: Icons.work_outline,
        ),
        RectFeatureTile(
          title: 'Contrats IA',
          subtitle:
              'Contrats adaptés : prestation, NDA, CDI, CDD, bail, partenariat.',
          icon: Icons.file_copy_outlined,
        ),
        RectFeatureTile(
          title: 'Factures & Devis',
          subtitle:
              'Factures pro : calcul TVA, logo, export PDF et historique.',
          icon: Icons.receipt_long,
        ),
        RectFeatureTile(
          title: 'Sécurité & Confidentialité',
          subtitle: 'Données chiffrées, backups automatiques, RGPD.',
          icon: Icons.lock_outline,
        ),
        RectFeatureTile(
          title: 'Conçu pour l\'Afrique',
          subtitle:
              'Devises locales, règles juridiques et contextes régionaux.',
          icon: Icons.public,
        ),
        RectFeatureTile(
          title: 'Automatisation',
          subtitle: 'Relances automatiques, signatures, workflows.',
          icon: Icons.bolt,
        ),
      ],
    );
  }
}

class RectFeatureTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const RectFeatureTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  @override
  State<RectFeatureTile> createState() => _RectFeatureTileState();
}

class _RectFeatureTileState extends State<RectFeatureTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: DS.bgTertiary,
          borderRadius: BorderRadius.circular(DS.radiusLg),
          border: Border.all(
            color: _hover ? DS.accentPrimary : DS.borderSubtle,
          ),
          boxShadow: _hover ? DS.glowMd : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    DS.accentPrimary.withValues(alpha: 0.2),
                    DS.accentPrimary.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(
                  color: DS.accentPrimary.withValues(alpha: 0.12),
                ),
              ),
              child: Icon(widget.icon, color: DS.accentPrimary, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: DS.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      color: DS.textTertiary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'En savoir plus',
                        style: TextStyle(
                          color: DS.accentPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: DS.accentPrimary,
                      ),
                    ],
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

/* ---------------- KEY VALUES SECTION ---------------- */
class KeyValuesSection extends StatelessWidget {
  const KeyValuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final values = [
      _ValueItem(
        icon: Icons.trending_up,
        title: "Scalabilité",
        description: "Passez de 1 à 100 documents sans changer d’outil.",
      ),
      _ValueItem(
        icon: Icons.verified_user,
        title: "Sécurité",
        description:
            "Vos données sont sécurisées et hébergées sur des serveurs certifiés.",
      ),
      _ValueItem(
        icon: Icons.pie_chart,
        title: "Insights",
        description: "Analysez en un coup d’œil vos activités administratives.",
      ),
      _ValueItem(
        icon: Icons.map,
        title: "Localisé Afrique",
        description:
            "Contrats adaptés aux usages légaux de l’Afrique francophone.",
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (width < 900) {
          return Column(
            children: values
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: e,
                  ),
                )
                .toList(),
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: values
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: e,
                    ),
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }
}

class _ValueItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ValueItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DS.bgSecondary,
            shape: BoxShape.circle,
            border: Border.all(color: DS.borderSubtle),
          ),
          child: Icon(icon, size: 32, color: DS.accentPrimary),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            color: DS.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: DS.textTertiary,
            fontSize: 14,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/* ---------------- TESTIMONIALS SECTION (NOUVEAU) ---------------- */
class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final testimonials = [
      _TestimonialCard(
        name: "Amara Koné",
        role: "Freelance Marketing, Abidjan",
        text:
            "Avant Adminsuite, je perdais des heures sur mes devis. Maintenant, c'est réglé en 5 minutes. Mes clients apprécient le professionnalisme.",
      ),
      _TestimonialCard(
        name: "Sarah Diop",
        role: "Directrice RH, PME Tech",
        text:
            "L'outil de recrutement IA est bluffant. Nous avons généré des tests techniques pertinents pour nos développeurs en quelques clics.",
      ),
      _TestimonialCard(
        name: "Jean-Luc M.",
        role: "Consultant Juridique",
        text:
            "La conformité avec les lois OHADA est un vrai plus. Je recommande cet outil à tous mes clients entrepreneurs.",
      ),
    ];

    return Column(
      children: [
        const Text(
          'Ils nous font confiance',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: DS.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Découvrez pourquoi les entrepreneurs africains choisissent Adminsuite.',
          style: TextStyle(fontSize: 16, color: DS.textTertiary),
        ),
        const SizedBox(height: 48),

        LayoutBuilder(
          builder: (context, constraints) {
            if (width < 900) {
              return Column(
                children: testimonials
                    .map(
                      (t) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: t,
                      ),
                    )
                    .toList(),
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: testimonials
                    .map(
                      (t) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: t,
                        ),
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
      ],
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String role;
  final String text;

  const _TestimonialCard({
    required this.name,
    required this.role,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: DS.bgTertiary,
        borderRadius: BorderRadius.circular(DS.radiusLg),
        border: Border.all(color: DS.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: DS.accentPrimary.withValues(alpha: 0.2),
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: DS.accentPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: DS.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      role,
                      style: const TextStyle(
                        color: DS.textTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '"$text"',
            style: const TextStyle(
              color: DS.textSecondary,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              5,
              (index) =>
                  const Icon(Icons.star, color: Color(0xFFFFAB1E), size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- FAQ SECTION (NOUVEAU) ---------------- */
class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Questions Fréquentes',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: DS.textPrimary,
          ),
        ),
        const SizedBox(height: 48),
        const _FaqItem(
          question: "Mes données sont-elles sécurisées ?",
          answer:
              "Absolument. Nous utilisons un cryptage de niveau bancaire (AES-256) et vos données sont hébergées sur des serveurs sécurisés conformes aux normes internationales.",
        ),
        const _FaqItem(
          question: "Puis-je utiliser Adminsuite sur mon téléphone ?",
          answer:
              "Oui, notre plateforme est 100% responsive. Vous pouvez générer des factures et signer des contrats directement depuis votre smartphone.",
        ),
        const _FaqItem(
          question: "Acceptez-vous les paiements par Mobile Money ?",
          answer:
              "Oui, nous acceptons Orange Money, MTN Mobile Money, Wave et les cartes bancaires classiques pour tous nos abonnements.",
        ),
        const _FaqItem(
          question: "Puis-je annuler mon abonnement à tout moment ?",
          answer:
              "Tout à fait. Nos offres sont sans engagement. Vous pouvez annuler ou changer de plan directement depuis votre espace client.",
        ),
      ],
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: DS.bgSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isExpanded
              ? DS.accentPrimary.withValues(alpha: 0.5)
              : DS.borderSubtle,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: Text(
            widget.question,
            style: const TextStyle(
              color: DS.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          iconColor: DS.accentPrimary,
          collapsedIconColor: DS.textTertiary,
          onExpansionChanged: (expanded) {
            setState(() => _isExpanded = expanded);
          },
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Text(
                widget.answer,
                style: const TextStyle(color: DS.textTertiary, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- HOW IT WORKS ---------------- */
class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Comment utiliser Adminsuite',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: DS.textPrimary,
          ),
        ),
        SizedBox(height: DS.s2),
        Text(
          'Adminsuite simplifie votre administratif en trois étapes simples : renseignez, générez avec l’IA, exportez.',
          style: TextStyle(fontSize: 16, color: DS.textTertiary),
        ),
        SizedBox(height: DS.s4),
        StepItem(
          icon: Icons.upload_file,
          title: '1. Renseignez vos informations',
          subtitle:
              'Déposez votre offre, les données d’un contrat ou les détails d’une facture.',
        ),
        SizedBox(height: DS.s3),
        StepItem(
          icon: Icons.auto_awesome,
          title: '2. L’IA génère le document',
          subtitle:
              'L’IA prépare automatiquement un document professionnel et conforme.',
        ),
        SizedBox(height: DS.s3),
        StepItem(
          icon: Icons.download,
          title: '3. Exportez et utilisez',
          subtitle:
              'Téléchargez en PDF, signez électroniquement ou envoyez par email.',
        ),
      ],
    );

    final visualContent = Container(
      decoration: BoxDecoration(
        color: DS.bgSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: DS.borderBright),
      ),
      child: const HowItWorksIllustration(),
    );

    // LOGIQUE RESPONSIVE
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: textContent),
          const SizedBox(width: 32),
          Expanded(flex: 5, child: visualContent),
        ],
      );
    } else {
      return Column(
        children: [
          textContent,
          const SizedBox(height: 32),
          visualContent, // Pas d'Expanded ici !
        ],
      );
    }
  }
}

class StepItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const StepItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                DS.accentPrimary.withValues(alpha: 0.15),
                DS.accentPrimary.withValues(alpha: 0.04),
              ],
            ),
            border: Border.all(color: DS.accentPrimary.withValues(alpha: 0.18)),
          ),
          child: Icon(icon, color: DS.accentPrimary, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: DS.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: DS.textTertiary)),
            ],
          ),
        ),
      ],
    );
  }
}

class HowItWorksIllustration extends StatelessWidget {
  const HowItWorksIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCard(
            offset: const Offset(-80, -60),
            scale: 0.85,
            opacity: 0.5,
            color: DS.bgSecondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSkeletonLine(width: 80),
                const SizedBox(height: 10),
                _buildSkeletonLine(width: 120),
                const SizedBox(height: 10),
                _buildSkeletonLine(width: 100),
              ],
            ),
          ),
          _buildCard(
            offset: const Offset(80, 60),
            scale: 1.0,
            opacity: 1.0,
            color: DS.bgTertiary,
            borderColor: DS.accentPrimary.withValues(alpha: 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 48,
                  color: DS.accentPrimary,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Document Prêt",
                  style: TextStyle(
                    color: DS.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: DS.accentPrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "PDF Généré",
                    style: TextStyle(color: DS.accentPrimary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DS.bgPrimary,
                border: Border.all(color: DS.accentPrimary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: DS.accentPrimary.withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: DS.accentPrimary,
                size: 40,
              ),
            ),
          ),
          Positioned(top: 100, right: 120, child: _dot(4)),
          Positioned(bottom: 120, left: 100, child: _dot(6)),
          Positioned(top: 150, left: 80, child: _dot(3)),
        ],
      ),
    );
  }

  Widget _dot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: DS.accentPrimary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: DS.accentPrimary.withValues(alpha: 0.6),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required Offset offset,
    required double scale,
    required double opacity,
    required Color color,
    Color? borderColor,
    required Widget child,
  }) {
    return Transform.translate(
      offset: offset,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 220,
          height: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderColor ?? DS.borderSubtle,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSkeletonLine({required double width}) {
    return Container(
      width: width,
      height: 10,
      decoration: BoxDecoration(
        color: DS.borderSubtle,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

/* ---------------- PRICING SECTION ---------------- */
class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Titre
    return Column(
      children: [
        const Text(
          'Nos Tarifs',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: DS.textPrimary,
          ),
        ),
        const SizedBox(height: DS.s2),
        const Text(
          'Choisissez la formule adaptée à votre croissance.',
          style: TextStyle(fontSize: 16, color: DS.textTertiary),
        ),
        const SizedBox(height: DS.s5),

        // Grille de cartes de prix
        LayoutBuilder(
          builder: (context, constraints) {
            // Sur mobile, colonne simple. Sur desktop, wrap ou row.
            if (width < 900) {
              return Column(
                children: const [
                  PricingCard(
                    title: "Freemium",
                    price: "Gratuit",
                    description: "Pour tester la plateforme.",
                    features: [
                      "2 documents gratuits",
                      "Puis passage en payant",
                    ],
                    isHighlighted: false,
                  ),
                  SizedBox(height: 24),
                  PricingCard(
                    title: "Pack Individuel",
                    price: "12 000 F / mois",
                    subtitle: "ou 3 000 FCFA / document",
                    description: "Idéal pour les freelances.",
                    features: [
                      "Documents illimités (si abo)",
                      "Accès tous modèles",
                      "Support email",
                    ],
                    isHighlighted: true, // Mise en avant
                  ),
                  SizedBox(height: 24),
                  PricingCard(
                    title: "Pack PME",
                    price: "29 000 F / mois",
                    description: "Pour les petites structures.",
                    features: [
                      "200 documents mensuels",
                      "3 comptes utilisateurs",
                      "Support prioritaire",
                    ],
                    isHighlighted: false,
                  ),
                  SizedBox(height: 24),
                  PricingCard(
                    title: "Cabinet RH / Juridique",
                    price: "75 000 F / mois",
                    description: "Pour les besoins intensifs.",
                    features: [
                      "Utilisateurs illimités",
                      "Branding personnalisé",
                      "API privée",
                    ],
                    isHighlighted: false,
                  ),
                ],
              );
            } else {
              // Version Desktop (Grid 4 colonnes ou Wrap)
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: const [
                  PricingCardDesktop(
                    title: "Freemium",
                    price: "Gratuit",
                    description: "Pour tester.",
                    features: ["2 documents gratuits", "Accès limité"],
                  ),
                  PricingCardDesktop(
                    title: "Pack Individuel",
                    price: "12 000 F / mois",
                    subtitle: "ou 3k/doc",
                    description: "Freelances",
                    features: ["Documents illimités", "Tous modèles"],
                    isHighlighted: true,
                  ),
                  PricingCardDesktop(
                    title: "Pack PME",
                    price: "29 000 F / mois",
                    description: "Croissance",
                    features: ["200 documents", "3 utilisateurs"],
                  ),
                  PricingCardDesktop(
                    title: "Cabinet RH",
                    price: "75 000 F / mois",
                    description: "Experts",
                    features: ["Utilisateurs illimités", "API & Branding"],
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

// Widget Carte Prix Mobile (Largeur full)
class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String? subtitle;
  final String description;
  final List<String> features;
  final bool isHighlighted;

  const PricingCard({
    required this.title,
    required this.price,
    this.subtitle,
    required this.description,
    required this.features,
    required this.isHighlighted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: DS.bgSecondary,
        borderRadius: BorderRadius.circular(DS.radiusLg),
        border: Border.all(
          color: isHighlighted ? DS.accentPrimary : DS.borderSubtle,
          width: isHighlighted ? 1.5 : 1,
        ),
        boxShadow: isHighlighted ? DS.glowMd : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isHighlighted ? DS.accentPrimary : DS.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            price,
            style: const TextStyle(
              color: DS.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(color: DS.textTertiary, fontSize: 14),
            ),
          const SizedBox(height: 12),
          Text(description, style: const TextStyle(color: DS.textTertiary)),
          const SizedBox(height: 24),
          const Divider(color: DS.borderSubtle),
          const SizedBox(height: 24),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.check, size: 16, color: DS.accentPrimary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: const TextStyle(color: DS.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? DS.accentPrimary
                    : DS.bgTertiary,
                foregroundColor: isHighlighted ? Colors.black : DS.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Choisir",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Carte Prix Desktop
class PricingCardDesktop extends StatelessWidget {
  final String title;
  final String price;
  final String? subtitle;
  final String description;
  final List<String> features;
  final bool isHighlighted;

  const PricingCardDesktop({
    required this.title,
    required this.price,
    this.subtitle,
    required this.description,
    required this.features,
    this.isHighlighted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260, // Largeur fixe pour desktop
      padding: const EdgeInsets.all(24),
      transform: isHighlighted ? Matrix4.translationValues(0, -10, 0) : null,
      decoration: BoxDecoration(
        color: DS.bgSecondary,
        borderRadius: BorderRadius.circular(DS.radiusLg),
        border: Border.all(
          color: isHighlighted ? DS.accentPrimary : DS.borderSubtle,
          width: isHighlighted ? 2 : 1,
        ),
        boxShadow: isHighlighted ? DS.glowMd : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? DS.accentPrimary.withValues(alpha: 0.1)
                  : DS.bgTertiary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: isHighlighted ? DS.accentPrimary : DS.textTertiary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            price,
            style: const TextStyle(
              color: DS.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(color: DS.textTertiary, fontSize: 12),
            ),
          const SizedBox(height: 16),
          // Liste des features
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, size: 14, color: DS.accentPrimary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: const TextStyle(
                        color: DS.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? DS.accentPrimary
                    : DS.bgTertiary,
                foregroundColor: isHighlighted ? Colors.black : DS.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Choisir",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- CTA ---------------- */
class FinalCta extends StatelessWidget {
  const FinalCta({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Text(
            'Prêt à automatiser votre administratif ?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: DS.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Rejoignez des centaines d’entrepreneurs africains qui gagnent du temps chaque jour.',
            style: TextStyle(color: DS.textTertiary),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
              backgroundColor: DS.accentPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 12,
              shadowColor: DS.accentPrimary.withValues(alpha: 0.3),
            ),
            child: const Text(
              'Commencer gratuitement',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- FOOTER ---------------- */
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= DS.mobileMax;
    return Container(
      width: double.infinity,
      color: DS.bgPrimary,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: 48,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Col 1
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Adminsuite',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: DS.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'L’assistant IA qui simplifie votre administratif : recrutement, contrats et facturation.',
                      style: TextStyle(color: DS.textTertiary),
                    ),
                  ],
                ),
              ),
              // Col 2
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Produit',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: DS.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Fonctionnalités',
                      style: TextStyle(color: DS.textTertiary),
                    ),
                    SizedBox(height: 8),
                    Text('Tarifs', style: TextStyle(color: DS.textTertiary)),
                    SizedBox(height: 8),
                    Text('Roadmap', style: TextStyle(color: DS.textTertiary)),
                  ],
                ),
              ),
              // Col 3
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ressources',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: DS.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('Blog', style: TextStyle(color: DS.textTertiary)),
                    SizedBox(height: 8),
                    Text('Aide', style: TextStyle(color: DS.textTertiary)),
                    SizedBox(height: 8),
                    Text(
                      'Documentation',
                      style: TextStyle(color: DS.textTertiary),
                    ),
                  ],
                ),
              ),
              // Col 4
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: DS.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Email : contact@adminsuite.com',
                      style: TextStyle(color: DS.textTertiary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'WhatsApp : +225 00 00 00 00',
                      style: TextStyle(color: DS.textTertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(color: DS.borderBright),
          const SizedBox(height: 12),
          const Text(
            '© 2025 Adminsuite — Tous droits réservés',
            style: TextStyle(color: DS.textMuted),
          ),
        ],
      ),
    );
  }
}
