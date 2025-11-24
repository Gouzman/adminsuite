// lib/app/dashboard/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../module/Contrats/contracts_home_page.dart';
import '../../module/Contrats/contract_form_page.dart';
import '../../module/Contrats/contract_preview_page.dart';
import 'dashboard_routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Router interne : change la valeur pour changer la view
  final ValueNotifier<DashboardRoute> _route = ValueNotifier(
    DashboardRoute.home,
  );

  // Optionnel : stocker un payload (ex: id de contrat) - ici simple map
  Map<String, dynamic>? routePayload;

  @override
  void dispose() {
    _route.dispose();
    super.dispose();
  }

  void navigateTo(DashboardRoute r, {Map<String, dynamic>? payload}) {
    routePayload = payload;
    _route.value = r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D10),
      body: SafeArea(
        child: Row(
          children: [
            // SIDEBAR (fixe)
            _Sidebar(onNavigate: navigateTo, currentRouteNotifier: _route),
            // CONTENT
            Expanded(
              child: Column(
                children: [
                  _Topbar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ValueListenableBuilder<DashboardRoute>(
                        valueListenable: _route,
                        builder: (context, current, _) {
                          // AnimatedSwitcher pour transition propre
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: _buildRouteWidget(current),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteWidget(DashboardRoute route) {
    switch (route) {
      case DashboardRoute.home:
        return _DashboardHome(key: const ValueKey('home'));
      case DashboardRoute.contracts:
        return ContractsHomePage(
          key: const ValueKey('contracts_home'),
          onOpenForm: (contractType) => navigateTo(
            DashboardRoute.contracts,
            payload: {'openForm': contractType},
          ),
        );
      case DashboardRoute.invoices:
        return const _PlaceholderWidget(
          title: 'Factures (à implémenter)',
          key: ValueKey('invoices'),
        );
      case DashboardRoute.recruitment:
        return const _PlaceholderWidget(
          title: 'Recrutement (à implémenter)',
          key: ValueKey('recruitment'),
        );
      case DashboardRoute.settings:
        return const _PlaceholderWidget(
          title: 'Paramètres (à implémenter)',
          key: ValueKey('settings'),
        );
      default:
        return const _PlaceholderWidget(
          title: 'Non implémenté',
          key: ValueKey('default'),
        );
    }
  }
}

/* ---------------- Sidebar ---------------- */

class _Sidebar extends StatelessWidget {
  final void Function(DashboardRoute, {Map<String, dynamic>? payload})
  onNavigate;
  final ValueNotifier<DashboardRoute> currentRouteNotifier;

  const _Sidebar({
    required this.onNavigate,
    required this.currentRouteNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1315),
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.03)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D166), Color(0xFF00F580)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shield, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Text(
                'Adminsuite',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // menu items (ValueListenableBuilder to reflect active state)
          ValueListenableBuilder<DashboardRoute>(
            valueListenable: currentRouteNotifier,
            builder: (context, current, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _menuItem(
                    context,
                    icon: Icons.dashboard,
                    label: 'Tableau de bord',
                    route: DashboardRoute.home,
                    active: current == DashboardRoute.home,
                  ),
                  _menuItem(
                    context,
                    icon: Icons.insert_drive_file,
                    label: 'Contrats',
                    route: DashboardRoute.contracts,
                    active: current == DashboardRoute.contracts,
                  ),
                  _menuItem(
                    context,
                    icon: Icons.receipt_long,
                    label: 'Factures',
                    route: DashboardRoute.invoices,
                    active: current == DashboardRoute.invoices,
                  ),
                  _menuItem(
                    context,
                    icon: Icons.people,
                    label: 'Recrutement',
                    route: DashboardRoute.recruitment,
                    active: current == DashboardRoute.recruitment,
                  ),
                  const SizedBox(height: 20),
                  _menuItem(
                    context,
                    icon: Icons.settings,
                    label: 'Paramètres',
                    route: DashboardRoute.settings,
                    active: current == DashboardRoute.settings,
                  ),
                ],
              );
            },
          ),

          const Spacer(),
          Text(
            'v1.0',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required DashboardRoute route,
    required bool active,
  }) {
    return InkWell(
      onTap: () => onNavigate(route),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.green.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: active ? const Color(0xFF00D166) : Colors.white54,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                color: active ? Colors.white : Colors.white70,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- Topbar ---------------- */

class _Topbar extends StatelessWidget {
  const _Topbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.02)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'Rechercher...',
                        hintStyle: TextStyle(color: Colors.white60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white54),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white24,
            child: Text('EG', style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

/* ---------------- Dashboard Home minimal ---------------- */

class _DashboardHome extends StatelessWidget {
  const _DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('dashboard_home_scroll'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tableau de bord',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // ici tu peux remettre les widgets de stats, chart, table...
          Container(
            height: 420,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF141618),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Contenu du dashboard (stats / chart / table)',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- Placeholder simple ---------------- */

class _PlaceholderWidget extends StatelessWidget {
  final String title;
  const _PlaceholderWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.inter(color: Colors.white54, fontSize: 18),
      ),
    );
  }
}
