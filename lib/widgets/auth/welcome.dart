import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/services/authentication.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    return Column(
      children: <Widget>[
        (authentication.firebasAuth.currentUser != null &&
                authentication.firebasAuth.currentUser!.isAnonymous)
            ? Material(
                child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            : Container(),
        const Spacer(
          flex: 5,
        ),
        const Image(
          height: 150,
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/images/oficiospe_logo.png'),
        ),
        const Spacer(
          flex: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w300),
              children: [
                const TextSpan(
                  text: 'Encuentra trabajo ',
                ),
                TextSpan(
                  text: 'fácil ',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const TextSpan(
                  text: 'y',
                ),
                TextSpan(
                  text: ' seguro',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        ),
        Container(
          constraints: const BoxConstraints.expand(height: 56),
          margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.email_outlined),
            label: Container(
              alignment: Alignment.center,
              child: const Text(
                'INGRESA CON TU EMAIL',
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              if (authProvider.welcomePageIndex == 0) {
                authProvider.welcomePageIndex = 1;
                authProvider.lastPageIndex = 0;
              }
            },
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Container(
          constraints: const BoxConstraints.expand(height: 56),
          margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              alignment: Alignment.centerLeft,
            ),
            icon: Image.asset(
              'assets/images/google_logo.png',
              height: 24,
              width: 24,
            ),
            label: Container(
              alignment: Alignment.center,
              child: const Text(
                'INGRESA CON GOOGLE',
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () async {
              try {
                if (authentication.firebasAuth.currentUser == null) {
                  await context
                      .read<AuthenticationProvider>()
                      .signInWithGoogle();
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'credential-already-in-use') {
                  showDialog(
                    context: context,
                    builder: (bc) {
                      return AlertDialog(
                        title: const Text('Deseas ingresar?'),
                        content: const Text(
                            'Ya hay una cuenta de google registrada, '
                            'si deseas puedes ingresar con esa cuenta.'),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            child: const Text('REGRESAR'),
                            onPressed: () {
                              Navigator.of(bc).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            child: const Text('INGRESAR'),
                            onPressed: () async {
                              Navigator.of(bc).pop();
                              try {
                                await context
                                    .read<AuthenticationProvider>()
                                    .signInWithGoogle();
                                Navigator.of(context).pop();
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-disabled') {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('No puedes ingresar'),
                                        content: const Text(
                                            'La cuenta ingresada ha sido deshabilitada'),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                primary: Theme.of(context)
                                                    .primaryColor),
                                            child: const Text('ENTIENDO'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } on Exception catch (_) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Ups, ocurrió una 🥑 (problema)'),
                                ));
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (e.code == 'user-disabled') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('No puedes ingresar'),
                        content: const Text(
                            'La cuenta ingresada ha sido deshabilitada'),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            child: const Text('ENTIENDO'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              } on Exception catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Ups, ocurrió una 🥑 (problema)'),
                ));
              }
            },
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
