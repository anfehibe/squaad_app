import 'package:go_router/go_router.dart';
import 'package:squaad_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: ActiveLicenseScreen.name,
      builder: (context, state) => const ActiveLicenseScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: DashboardScreen.name,
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
