import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/services/authentication.dart';

import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () => Future.sync(() {
        if (authProvider.welcomePageIndex == 1) {
          authProvider.welcomePageIndex = 0;
          authProvider.lastPageIndex = 1;
        }
        return false;
      }),
      child: Column(
        children: [
          Material(
            child: Container(
              height: 56,
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (authProvider.welcomePageIndex == 1) {
                    authProvider.welcomePageIndex = 0;
                    authProvider.lastPageIndex = 1;
                  }
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Ingresa tus datos',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: TextFormField(
                    onSaved: (value) => _email = value!.trim(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: TextFormField(
                    onSaved: (value) => _password = value!.trim(),
                    obscureText: !visible,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(
                            visible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 24,
                  ),
                  child: InkWell(
                    child: const Text(
                      "Olvide mi contraseña",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          String emailText = "";
                          return AlertDialog(
                            title: const Text('Ingresa tu Correo'),
                            content: TextFormField(
                              onSaved: (value) => emailText = value!.trim(),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Correo electrónico',
                              ),
                            ),
                            actions: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancelar")),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () async {
                                    await context
                                        .read<AuthenticationProvider>()
                                        .forgotPassword(emailText);
                                  },
                                  child: const Text("Enviar")),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: const Text(
                          "REGÍSTRATE",
                        ),
                        onPressed: () {
                          if (authProvider.welcomePageIndex == 1) {
                            authProvider.welcomePageIndex = 2;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 24,
                          left: 8,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: const Text(
                            "INGRESA",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                FocusScope.of(context).unfocus();
                                if (authentication.firebasAuth.currentUser !=
                                    null) {
                                  if (authentication
                                      .firebasAuth.currentUser!.isAnonymous) {
                                    await context
                                        .read<AuthenticationProvider>()
                                        .signInWithEmail(_email, _password);
                                    Navigator.pop(context);
                                  }
                                } else {
                                  await context
                                      .read<AuthenticationProvider>()
                                      .signInWithEmail(_email, _password);
                                }
                              }
                            } on FirebaseAuthException catch (e) {
                              String snackBarMessage = "";
                              switch (e.code) {
                                case 'invalid-email':
                                  snackBarMessage = 'Correo inválido';
                                  break;
                                case 'user-disabled':
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
                                  break;
                                case 'user-not-found':
                                  snackBarMessage = 'No existe el usuario';
                                  break;
                                case 'wrong-password':
                                  snackBarMessage = 'No existe el usuario';
                                  break;
                                default:
                                  snackBarMessage =
                                      'Ups, ocurrió una 🥑 (problema)';
                                  break;
                              }
                              if (snackBarMessage != "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(snackBarMessage),
                                ));
                              }
                            } on Exception catch (_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Ups, ocurrió una 🥑 (problema)'),
                              ));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
