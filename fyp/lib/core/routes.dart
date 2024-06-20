import 'package:flutter/cupertino.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/staff_notification_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/staff_visitor_details_screen.dart';
import 'package:fyp/presentation/pages/Staff/auth/provider/staff_login_provider.dart';
import 'package:fyp/presentation/pages/Staff/auth/staff_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/provider/visitor_login_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/provider/visitor_signup_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_signup_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/provider/visitor_appointment_form_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/auth_options_screen.dart';
import 'package:fyp/presentation/pages/LoadingScreens/visitor_loading_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/otp_screen.dart';
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

      case VisitorLoadingScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const VisitorLoadingScreen(),
        );

      case SelectUserScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SelectUserScreen(),
        );

      case AuthOptionScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const AuthOptionScreen(),
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

      case OtpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const OtpScreen(),
        );

      case VisitorHomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => VisitorAppointmentFormProvider(context),
              child: const VisitorHomeScreen()),
        );

      case StaffLoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => StaffLoginProvider(context),
            child: const StaffLoginScreen(),
          ),
        );

      case StaffHomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const StaffHomeScreen(),
        );

      case StaffNotificationScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const StaffNotificationScreen(),
        );

      case StaffVisitorDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const StaffVisitorDetailsScreen(),
        );

      case SecurityHomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SecurityHomeScreen(),
        );

      default:
        return null;
    }
  }
}
