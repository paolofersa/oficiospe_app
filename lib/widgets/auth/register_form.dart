import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/services/authentication.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterForm extends StatefulWidget {
  final void Function(int) onClickContinueButton;

  const RegisterForm({required this.onClickContinueButton, Key? key})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _name = "";
  String _phone = "";

  bool visible = false;

  bool onWillPop() {
    widget.onClickContinueButton(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return WillPopScope(
      onWillPop: () => Future.sync(() {
        if (authProvider.welcomePageIndex == 2) {
          authProvider.welcomePageIndex = 1;
          authProvider.lastPageIndex = 2;
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
                  if (authProvider.welcomePageIndex == 2) {
                    authProvider.welcomePageIndex = 1;
                    authProvider.lastPageIndex = 2;
                  }
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Regístrate',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Campo vacío' : null;
                    },
                    onSaved: (value) => _name = value!.trim(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: TextFormField(
                    validator: (value) {
                      RegExp emailRegExp = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
                      emailRegExp.hasMatch(value!);
                      if (value.isEmpty) {
                        return 'Campo vacío';
                      } else if (!emailRegExp.hasMatch(value)) {
                        return 'Correo no valido';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => _email = value!.trim(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo vacío';
                      } else if (value.length < 6) {
                        return 'La contraseña debe tener 6 caracteres como minimo';
                      } else if (value.length > 20) {
                        return 'La contraseña debe tener 20 caracteres como maximo';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => _password = value!.trim(),
                    obscureText: !visible,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Contraseña',
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                            visible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo vacío';
                      } else if (value.length != 9) {
                        return 'Celular no valido';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => _phone = value!.trim(),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Celular',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, right: 24),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      "REGÍSTRATE",
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
                          if (authentication.firebasAuth.currentUser == null) {
                            await context.read<AuthenticationProvider>().signUp(
                                  _email,
                                  _password,
                                  _name,
                                  _phone,
                                );
                          }
                          Navigator.pop(context);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use' ||
                            e.code == 'credential-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ya hay una cuenta registrada'),
                            ),
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
                                        primary:
                                            Theme.of(context).primaryColor),
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
                          content: Text('Ups, ocurrió una 🥑 (problema)'),
                        ));
                      }
                    },
                  ),
                ),
                Container(
                  height: height / 40,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 32, right: 30),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.subtitle1,
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Al registrarte aceptas nuestros '),
                        TextSpan(
                          text: 'Términos y Condiciones',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch('https://flutter.dev');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
