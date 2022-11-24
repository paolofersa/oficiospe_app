import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0.0, 1.00),
              blurRadius: 4.00,
              color: Colors.grey,
              spreadRadius: 1.00),
        ],
      ),
      height: 65,
      margin: const EdgeInsets.all(16.0),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 50),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (homeProvider.bottomNavIndex != index) {
              homeProvider.bottomNavIndex = index;
            }
          },
          currentIndex: homeProvider.bottomNavIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account_outlined),
              label: 'Trabajos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorirtos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_tree_outlined),
              label: 'Proceso',
            ),
          ],
        ),
      ),
    );
  }
}
