import 'package:flutter/material.dart';

class InitializePage extends StatelessWidget {
  const InitializePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
