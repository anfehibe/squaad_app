import 'package:go_router/go_router.dart';
import 'package:squaad_app/presentation/screens/license/active_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: ActiveLicenseScreen.name,
      builder: (context, state) => const ActiveLicenseScreen(),
    ),
  ],
);
