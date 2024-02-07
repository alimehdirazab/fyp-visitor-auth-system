import 'package:flutter/cupertino.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/provider/visitor_login_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/provider/visitor_signup_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_signup_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';
import 'package:fyp/presentation/pages/select_user_screen.dart';
import 'package:fyp/presentation/pages/splash_screen.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case LoadingScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LoadingScreen(),
        );

      case SelectUserScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SelectUserScreen(),
        );

      case VisitorLoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => VisitorLoginProvider(context),
            child: const VisitorLoginScreen(),
          ),
        );

      case VisitorSignupScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => VisitorSignupProvider(context),
            child: const VisitorSignupScreen(),
          ),
        );

      case VisitorHomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const VisitorHomeScreen(),
        );

      default:
        return null;
    }
  }
}
