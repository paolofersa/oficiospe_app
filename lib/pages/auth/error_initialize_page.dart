import 'package:flutter/material.dart';

class ErrorInitializePage extends StatelessWidget {
  const ErrorInitializePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
              child: Image.asset(
                'assets/images/server_failed.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
              child: Text(
                'Servidores fuera de servicio',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
              child: Text(
                  'Lo sentimos, no podemos conectar con nuestros servidores en este momento.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
