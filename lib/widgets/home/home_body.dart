import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/pages/home/favorite_page.dart';
import 'package:oficiospe_app_employee/pages/home/jobs_page.dart';
import 'package:oficiospe_app_employee/pages/home/process_page.dart';
import 'package:oficiospe_app_employee/pages/home/profile_page.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/widgets/home/home_bottom_navigation_bar.dart';

import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  final List<Widget> pages = [];

  HomeBody({Key? key}) : super(key: key);
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    Widget pageToMove = SafeArea(
      child: Container(),
    );

    switch (homeProvider.bottomNavIndex) {
      case 0:
        pageToMove = const ProfilePage();
        break;
      case 1:
        pageToMove = const JobsPage();
        break;
      case 2:
        pageToMove = const FavoritePage();
        break;
      case 3:
        pageToMove = const ProcessPage();
        break;
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: pageToMove,
        ),
        const HomeBottomNavigationBar()
      ],
    );
  }
}
