# Copilot Instructions for Adminsuite

## Vue d'ensemble
Adminsuite est une application Flutter multi-plateforme (mobile, web, desktop) dédiée à la gestion administrative pour entrepreneurs et PME d'Afrique francophone. Le code est organisé par plateformes (android, ios, web, linux, macos, windows) et par modules métier dans `lib/`.

## Architecture & Structure
- **Entrée principale** : `lib/main.dart` lance l'app avec le widget `AdminsuiteApp`.
- **Page d'accueil** : `lib/landing_page.dart` contient la landing page, la navigation, le design system, et les sections principales.
- **Modules métier** : Les fonctionnalités sont organisées dans `lib/app/` et `lib/module/` (ex : `dashboard`, `Contrats`).
- **Design System** : Les constantes de style (couleurs, espacements, etc.) sont centralisées dans la classe `DS` de `landing_page.dart`.
- **Assets** : Les images et ressources sont dans `assets/`.
- **Plateformes** : Les dossiers `android/`, `ios/`, `web/`, etc. contiennent la configuration et le code spécifique à chaque plateforme.

## Workflows Développeur
- **Build** : Utiliser la tâche VS Code `build` ou la commande `flutter build <platform>` pour compiler l'application.
- **Tests** : Les tests sont dans `test/`. Exécuter avec `flutter test`.
- **Debug** : Utiliser `flutter run` pour lancer l'app en mode debug sur la plateforme souhaitée.
- **Ajout de dépendances** : Modifier `pubspec.yaml` puis exécuter `flutter pub get`.

## Conventions & Patterns
- **Navigation** : Utiliser `Navigator.push` avec des routes Material pour la navigation entre pages (voir `_Hero` dans `landing_page.dart`).
- **Responsive** : Adapter l'UI selon la largeur d'écran avec des breakpoints définis dans `DS`.
- **Design** : Respecter les couleurs, espacements et typographies du design system.
- **Organisation** : Grouper les widgets réutilisables et les sections dans des classes dédiées (ex : `FeaturesGrid`, `TestimonialsSection`).
- **Assets** : Charger les images avec `Image.asset` et gérer les erreurs d'affichage.

## Points d'intégration
- **Dépendances externes** : Utilise `google_fonts`, `url_launcher` (voir imports dans `main.dart`).
- **Plateformes** : Adapter le code pour chaque plateforme si nécessaire (voir dossiers spécifiques).

## Exemples de patterns
- Navigation :
  ```dart
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const DashboardPage(),
    ),
  );
  ```
- Responsive :
  ```dart
  final isMobile = width <= DS.mobileMax;
  ```
- Design System :
  ```dart
  color: DS.accentPrimary
  ```

## Fichiers clés
- `lib/main.dart` : Entrée de l'app
- `lib/landing_page.dart` : Page d'accueil, design system, navigation
- `lib/app/`, `lib/module/` : Modules métier
- `assets/` : Images et ressources
- `pubspec.yaml` : Dépendances Flutter

---
Mettez à jour ce fichier si des conventions ou workflows changent. Pour toute ambiguïté, demandez des précisions sur l'organisation ou les pratiques spécifiques du projet.
