import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/widgets/home/home_body.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget loadingHomeBody = const Center(child: CircularProgressIndicator());
    final homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: homeProvider.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            loadingHomeBody = HomeBody();
          }
          if (snapshot.hasError) {
            loadingHomeBody = const SafeArea(
              child: Text("ERROR"),
            );
            //TODO: Manerjar excepciones
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
            child: loadingHomeBody,
          );
        },
      ),
    );
  }
}
