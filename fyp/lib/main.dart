import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/routes.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/otp_screen.dart';

import 'package:fyp/presentation/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Globel object for access mobile screen size
late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences instance = await SharedPreferences.getInstance();
  instance.clear();

  Bloc.observer = MyBlocOberver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // late Size mq = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VisitorCubit()),
        BlocProvider(create: (context) => StaffCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smiu Visitor Authorization System',
        theme: Themes.defaultTheme,
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: SplashScreen.routeName,
        //initialRoute: OtpScreen.routeName,
      ),
    );
  }
}

class MyBlocOberver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed : $bloc");
    super.onClose(bloc);
  }
}
