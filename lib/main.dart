import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/pages/auth/error_initialize_page.dart';
import 'package:oficiospe_app_employee/pages/auth/initialize_page.dart';
import 'package:oficiospe_app_employee/pages/auth/welcome_page.dart';
import 'package:oficiospe_app_employee/pages/home/home_page.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

Future<FirebaseApp> initializeFirebaseServices() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();

  return firebaseApp;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget progressToApp = const InitializePage();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: MaterialApp(
        title: 'Psico20',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xFF2A5CFC,
            {
              50: Color.fromRGBO(42, 92, 252, .1),
              100: Color.fromRGBO(42, 92, 252, .2),
              200: Color.fromRGBO(42, 92, 252, .3),
              300: Color.fromRGBO(42, 92, 252, .4),
              400: Color.fromRGBO(42, 92, 252, .5),
              500: Color.fromRGBO(42, 92, 252, .6),
              600: Color.fromRGBO(42, 92, 252, .7),
              700: Color.fromRGBO(42, 92, 252, .8),
              800: Color.fromRGBO(42, 92, 252, .9),
              900: Color.fromRGBO(42, 92, 252, 1),
            },
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            headline2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
            headline3: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
            bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
            bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
          ),
          chipTheme: ChipTheme.of(context).copyWith(),
        ),
        home: FutureBuilder(
          future: initializeFirebaseServices(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              progressToApp = const ErrorInitializePage();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              progressToApp = const Authenticate();
            }
            return PageTransitionSwitcher(
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: progressToApp,
            );
          },
        ),
      ),
    );
  }
}

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthenticationProvider>().authState,
      builder: (context, user) {
        return PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: (user.hasData)
              ? MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => HomeProvider()),
                  ],
                  child: const HomePage(),
                )
              : const WelcomePage(),
        );
      },
    );
  }
}
