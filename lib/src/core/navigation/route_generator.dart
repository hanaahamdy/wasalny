import 'package:flutter/material.dart';

import '../../features/auth/presentation/imports/view_imports.dart';
import '../../features/logic/home_tabs/stadiums/presentation/stadiums_feature.dart';
import '../../features/settings/splash/imports/view_imports.dart';
import '../../features/settings/team/presentation/imports/view_imports.dart';
import 'named_routes.dart';
import 'page_router/imports_page_router_builder.dart';

class RouterGenerator {
  RouterGenerator._();

  static final PageRouterBuilder _pageRouter = PageRouterBuilder();

  static Route<dynamic> getRoute(RouteSettings settings) {
    for (final namedRoute in NamedRoutes.values) {
      if (namedRoute.routeName != settings.name) continue;

      return switch (namedRoute) {
        NamedRoutes.splash => _pageRouter.build(
          const SplashScreen(),
          settings: settings,
        ),
        NamedRoutes.login => _pageRouter.build(
          const LoginScreen(),
          settings: settings,
        ),
        NamedRoutes.resetPassword => _pageRouter.build(
          const ResetPasswordScreen(),
          settings: settings,
        ),
        NamedRoutes.signUp => _pageRouter.build(
          const SignUpScreen(),
          settings: settings,
        ),
        NamedRoutes.team => _pageRouter.build(
          const TeamDetailsView(),
          settings: settings,
        ),
        NamedRoutes.stadiumSearch => _pageRouter.build(
          const StadiumSearchView(),
          settings: settings,
        ),
        NamedRoutes.stadiumDetails => _pageRouter.build(
          StadiumDetailsView(stadiumId: settings.arguments as int),
          settings: settings,
        ),
        NamedRoutes.bookingSummary => _pageRouter.build(
          BookingStadiumSummaryView(stadium: settings.arguments as Stadium),
          settings: settings,
        ),
      };
    }

    return undefineRoute();
  }

  static Route<dynamic> undefineRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('No route exists here ! '))),
    );
  }
}
