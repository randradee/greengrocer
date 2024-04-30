import 'package:get/get.dart';
import 'package:greengrocer/src/bindings/home_binding.dart';
import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

abstract class AppRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/signin',
      page: () => SignInScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: '/',
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/';
}
