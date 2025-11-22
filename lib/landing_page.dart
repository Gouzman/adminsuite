// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Définition des couleurs basées sur l'image
  static const Color darkGreen = Color(0xFF006633);
  static const Color brightOrange = Color(0xFFFFAB1E);
  static const double bannerHeight = 60.0;

  // Spacing (8pt system)
  static const double s1 = 8;
  static const double s2 = 16;
  static const double s3 = 24;
  static const double s4 = 32;
  static const double s5 = 48;
  static const double s6 = 64;
  static const double s7 = 80;
  static const double sectionPaddingDesktop = 120;
  static const double sectionPaddingMobile = 80;

  // Radii
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;

  // Shadows / glow (used as BoxShadow)
  static final List<BoxShadow> glowMd = [
    BoxShadow(
      color: DS.accentPrimary.withOpacity(0.2),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  // Breakpoints
  static const double mobileMax = 767;
  static const double tabletMax = 1023;
  static const double desktopMax = 1439;
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
          background: DS.bgPrimary,
          surface: DS.bgSecondary,
        ),
      ),
      home: const LandingPage(),
    );
  }
}

/* ---------------- LANDING PAGE ---------------- */
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri))
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
            // Nav
            const SizedBox(height: 12),
            TopNav(onCta: () => _launchUrl('https://adminsuite.example.com')),
            // Hero
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: sectionPadding,
                horizontal: _horizontalPadding(width),
              ),
              child: _Hero(width: width),
            ),
            // Partners strip
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const PartnersStrip(),
            ),
            const SizedBox(height: 32),
            // Value
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const ValueSection(),
            ),
            const SizedBox(height: 32),
            // Features grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const FeaturesGrid(),
            ),
            const SizedBox(height: 48),
            // How it works
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const HowItWorksSection(),
            ),
            const SizedBox(height: 48),
            // CTA
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(width),
              ),
              child: const FinalCta(),
            ),
            const SizedBox(height: 40),
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
                    shadowColor: DS.accentPrimary.withOpacity(0.3),
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
                // mobile menu placeholder
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
  const _NavText(this.text, {super.key});

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
  const _Hero({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = width > 1000;
    return Flex(
      direction: isWide ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left text
        Expanded(
          flex: isWide ? 5 : 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: DS.accentPrimary.withOpacity(0.12),
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
              // Title
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
                    onPressed: () {},
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
                      shadowColor: DS.accentPrimary.withOpacity(0.25),
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
                    onPressed: () {},
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
          ),
        ),

        const SizedBox(width: 28, height: 28),

        // Right mockup with radial glow
        Expanded(
          flex: isWide ? 5 : 0,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // radial glow (accent-glow-strong)
                Container(
                  width: 420,
                  height: 420,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: RadialGradient(
                      colors: [
                        DS.accentPrimary.withOpacity(0.28),
                        Colors.transparent,
                      ],
                      radius: 0.85,
                    ),
                  ),
                ),
                // Right visual (image + léger glow vert derrière)
                Expanded(
                  flex: isWide ? 5 : 0,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Nouveau glow vert plus léger et plus propre
                        Container(
                          width: 600,
                          height: 600,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                DS.accentPrimary.withValues(
                                  alpha: 0.18,
                                ), // léger glow
                                Colors.transparent,
                              ],
                              radius: 0.85,
                            ),
                          ),
                        ),

                        // 👉 nouvelle image principale (dame laptop)
                        Positioned(
                          bottom: 10,
                          child: Image.asset(
                            'assets/images/Dashboard.png', // tu renommeras ce fichier
                            width: 800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // floating mini-cards (visual only)
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
          ),
        ),
      ],
    );
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DS.bgSecondary.withOpacity(0.95),
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
    return Column(
      children: [
        const Text(
          'Déjà utilisé par des entrepreneurs et PME en Afrique francophone',
          style: TextStyle(color: DS.textTertiary),
        ),
      ],
    );
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

/* ---------------- FEATURES GRID (6 cards) ---------------- */
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
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    DS.accentPrimary.withOpacity(0.2),
                    DS.accentPrimary.withOpacity(0.05),
                  ],
                ),
                border: Border.all(color: DS.accentPrimary.withOpacity(0.12)),
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
                  const Spacer(),
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

/* ---------------- HOW IT WORKS (3 steps) ---------------- */
class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Flex(
      direction: isWide ? Axis.horizontal : Axis.vertical,
      children: [
        Expanded(
          flex: isWide ? 5 : 0,
          child: Column(
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
          ),
        ),
        const SizedBox(width: 32, height: 32),
        Expanded(
          flex: isWide ? 5 : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/hero_mockup.png',
              height: 420,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
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
                DS.accentPrimary.withOpacity(0.15),
                DS.accentPrimary.withOpacity(0.04),
              ],
            ),
            border: Border.all(color: DS.accentPrimary.withOpacity(0.18)),
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
              shadowColor: DS.accentPrimary.withOpacity(0.3),
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
