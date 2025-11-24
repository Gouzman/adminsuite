// lib/dashboard/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Dashboard Page - Adminsuite (Style: Premium noir + vert neon)
/// Placez ce fichier dans lib/dashboard/dashboard_page.dart
/// Si vous voulez utiliser l'illustration dashboard, copiez le fichier local suivant
/// vers assets/images/dashboard_arc.png (ou changez le chemin) :
/// /mnt/data/A_3D-rendered_digital_illustration_in_neon_green_h.png

class DS {
  DS._();
  static const accentPrimary = Color(0xFF00D166);
  static const bgPrimary = Color(0xFF0B0D10);
  static const bgSecondary = Color(0xFF0F1315);
  static const card = Color(0xFF141618);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFA7B0B5);
}

/// Entry point widget for Dashboard (use Navigator push from LandingPage)
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DS.bgPrimary,
      body: SafeArea(
        child: Row(
          children: const [
            // Sidebar (fixed)
            _Sidebar(),

            // Main content
            Expanded(child: _DashboardContent()),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------
   SIDEBAR
   ------------------------------ */
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: DS.bgSecondary,
        border: Border(
          right: BorderSide(color: Colors.white.withValues(alpha: 0.03)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D166), Color(0xFF00F580)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: DS.accentPrimary.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.shield, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Text(
                "Adminsuite",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: DS.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Menu
          _SidebarItem(
            icon: Icons.dashboard,
            label: "Tableau de bord",
            active: true,
          ),
          _SidebarItem(icon: Icons.insert_drive_file, label: "Contrats"),
          _SidebarItem(icon: Icons.receipt_long, label: "Factures"),
          _SidebarItem(icon: Icons.person_search, label: "Recrutement"),
          _SidebarItem(icon: Icons.history, label: "Historique"),
          const Spacer(),

          // Footer small
          Text(
            "Version 1.0",
            style: GoogleFonts.inter(color: DS.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            "© Adminsuite",
            style: GoogleFonts.inter(color: DS.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _SidebarItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: active
                  ? DS.accentPrimary.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: active ? DS.accentPrimary : DS.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              color: active ? DS.textPrimary : DS.textSecondary,
              fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------------------
   MAIN CONTENT
   ------------------------------ */
class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    // Responsive layout: if width < 1024, stack columns
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 1100;
    return Column(
      children: [
        // Topbar
        const _TopBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: isNarrow ? _buildStacked() : _buildGrid(),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column (content)
        Expanded(
          flex: 3,
          child: Column(
            children: const [
              _StatsRow(),
              SizedBox(height: 20),
              _ChartCard(),
              SizedBox(height: 20),
              _InvoiceTable(),
            ],
          ),
        ),

        const SizedBox(width: 20),

        // Right Column (quick actions + extras)
        SizedBox(
          width: 360,
          child: Column(
            children: const [
              _QuickActions(),
              SizedBox(height: 20),
              _SmallStats(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStacked() {
    return ListView(
      children: const [
        _StatsRow(),
        SizedBox(height: 20),
        _ChartCard(),
        SizedBox(height: 20),
        _QuickActions(),
        SizedBox(height: 20),
        _InvoiceTable(),
        SizedBox(height: 20),
        _SmallStats(),
      ],
    );
  }
}

/* ------------------------------
   TOPBAR
   ------------------------------ */
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.02)),
        ),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.inter(color: DS.textPrimary),
                      decoration: InputDecoration(
                        hintText: "Rechercher...",
                        hintStyle: GoogleFonts.inter(color: DS.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: DS.textSecondary),
          ),
          const SizedBox(width: 12),
          // Avatar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withValues(alpha: 0.06),
                  child: Text(
                    "EG",
                    style: GoogleFonts.inter(color: DS.textPrimary),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Elie Gouzou",
                      style: GoogleFonts.inter(
                        color: DS.textPrimary,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Admin",
                      style: GoogleFonts.inter(
                        color: DS.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------------------
   STATS ROW
   ------------------------------ */
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _StatsCard(title: "Contrats", value: "128", delta: "+12%"),
        SizedBox(width: 14),
        _StatsCard(title: "Factures payées", value: "1 024", delta: "+8%"),
        SizedBox(width: 14),
        _StatsCard(title: "Candidats", value: "342", delta: "+4%"),
        SizedBox(width: 14),
        _StatsCard(title: "Revenus (FCFA)", value: "1 200 000", delta: "+18%"),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String delta;
  const _StatsCard({
    required this.title,
    required this.value,
    required this.delta,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: DS.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
          boxShadow: [
            BoxShadow(
              color: DS.accentPrimary.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.inter(color: DS.textSecondary)),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: DS.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: DS.accentPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    delta,
                    style: GoogleFonts.inter(
                      color: DS.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------
   CHART CARD (placeholder)
   ------------------------------ */
class _ChartCard extends StatelessWidget {
  const _ChartCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: DS.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          // Left: mock chart area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Activité mensuelle",
                  style: GoogleFonts.inter(
                    color: DS.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Graphique (placeholder)",
                        style: TextStyle(color: Colors.white24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          // Right: small pie + mini stats
          SizedBox(
            width: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // fake donut
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [DS.accentPrimary, Color(0xFF00F580)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: DS.accentPrimary.withValues(alpha: 0.14),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "90%",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Taux de complétion",
                  style: GoogleFonts.inter(color: DS.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------------------
   INVOICE TABLE
   ------------------------------ */
class _InvoiceTable extends StatelessWidget {
  const _InvoiceTable();

  @override
  Widget build(BuildContext context) {
    // mock data
    final rows = [
      {"name": "M. Traoré", "status": "En attente", "amount": "200 000 FCFA"},
      {"name": "Mme. Kone", "status": "Payé", "amount": "5 000 FCFA"},
      {"name": "A. Diallo", "status": "Échoué", "amount": "3 000 FCFA"},
      {"name": "B. Sanogo", "status": "Payé", "amount": "1 200 FCFA"},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: DS.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Factures récentes",
            style: GoogleFonts.inter(
              color: DS.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  _tableHeader("Nom"),
                  _tableHeader("Statut"),
                  _tableHeader("Montant"),
                  _tableHeader(""),
                ],
              ),
              for (final r in rows)
                TableRow(
                  children: [
                    _tableCell(r["name"]!),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: _statusChip(r["status"]!),
                    ),
                    _tableCell(r["amount"]!),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert, color: DS.textSecondary),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: DS.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: GoogleFonts.inter(color: DS.textPrimary)),
    );
  }

  Widget _statusChip(String status) {
    Color bg;
    if (status.toLowerCase().contains("pay")) {
      bg = DS.accentPrimary.withValues(alpha: 0.16);
    } else if (status.toLowerCase().contains("attente") ||
        status.toLowerCase().contains("en attente")) {
      bg = Colors.orange.withValues(alpha: 0.14);
    } else {
      bg = Colors.red.withValues(alpha: 0.12);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(color: DS.textPrimary, fontSize: 12),
      ),
    );
  }
}

/* ------------------------------
   QUICK ACTIONS
   ------------------------------ */
class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: DS.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Actions rapides",
            style: GoogleFonts.inter(
              color: DS.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _actionButton(Icons.add, "Nouveau contrat"),
              _actionButton(Icons.receipt, "Nouvelle facture"),
              _actionButton(Icons.person_add, "Publier offre"),
              _actionButton(Icons.upload_file, "Importer"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.03),
        foregroundColor: DS.textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: DS.accentPrimary, size: 18),
      label: Text(label, style: GoogleFonts.inter()),
    );
  }
}

/* ------------------------------
   SMALL STATS (right column)
   ------------------------------ */
class _SmallStats extends StatelessWidget {
  const _SmallStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _smallCard("Utilisateurs actifs", "324", "En hausse"),
        const SizedBox(height: 12),
        _smallCard("Taux d'erreur", "0.3%", "Stable"),
      ],
    );
  }

  Widget _smallCard(String title, String value, String note) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DS.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(color: DS.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              color: DS.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: GoogleFonts.inter(color: DS.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
