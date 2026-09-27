import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/home_feed_screen/home_feed_screen.dart';
import '../presentation/car_detail_screen/car_detail_screen.dart';
import '../presentation/add_listing_screen/add_listing_screen.dart';
import '../widgets/app_scaffold.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/';
  static const String homeFeedScreen = '/home-feed-screen';
  static const String carDetailScreen = '/car-detail-screen';
  static const String addListingScreen = '/add-listing-screen';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 280),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.homeFeedScreen,
              builder: (context, state) => const HomeFeedScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.addListingScreen,
              builder: (context, state) => const AddListingScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.carDetailScreen,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return CustomTransitionPage(
          key: state.pageKey,
          child: CarDetailScreen(carData: extra),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 280),
        );
      },
    ),
  ],
);
