import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/widgets/auth/login_form.dart';
import 'package:oficiospe_app_employee/widgets/auth/register_form.dart';
import 'package:oficiospe_app_employee/widgets/auth/welcome.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<Widget> welcomePages = [
    const Welcome(),
    const LoginForm(),
    RegisterForm(
      onClickContinueButton: (_) {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse:
              (authProvider.welcomePageIndex <= authProvider.lastPageIndex),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: welcomePages[authProvider.welcomePageIndex],
        ),
      ),
    );
  }
}
