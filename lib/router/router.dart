import 'package:auto_route/auto_route.dart';
import 'package:saiyan_official/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // splash page route
    AutoRoute(page: SplashRoute.page, initial: true),

    // home page route
    AutoRoute(page: HomeRoute.page),

    // login page route
    AutoRoute(page: LoginRoute.page),

    // register page route
    AutoRoute(page: RegisterRoute.page),
  ];
}

final router = AppRouter();
