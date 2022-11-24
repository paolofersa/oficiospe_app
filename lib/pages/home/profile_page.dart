import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/pages/home/edit_profile_page.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/widgets/home/profile_item.dart';
import 'package:provider/provider.dart';
import 'package:oficiospe_app_employee/services/authentication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final Worker appUser = Provider.of<HomeProvider>(context).user;

    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Perfil',
                  style: Theme.of(context).textTheme.headline5!,
                ),
                const Image(
                  height: 35,
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/oficiospe_logo2.png'),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            width: double.infinity,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'Tus datos',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
                ProfileItem(label: 'Nombre', value: appUser.name),
                ProfileItem(label: 'Apellido', value: appUser.lastName),
                ProfileItem(label: 'Profesión', value: appUser.profession),
                ProfileItem(label: 'Conocimientos', value: appUser.knowledges),
                ProfileItem(label: 'Celular', value: appUser.phone),
                ProfileItem(label: 'Ciudad', value: appUser.city),
                ProfileItem(label: 'Edad', value: appUser.age.toString()),
                ProfileItem(label: 'Sexo', value: appUser.gender),
              ],
            ),
          ),
          Container(
            height: 16,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Editar Perfil',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      appUser: appUser,
                    ),
                  ),
                );
                setState(() {});
              },
            ),
          ),
          Container(
            height: 8,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Cerrar Sesion',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Quieres salir?'),
                      content: const Text(
                        'Estas seguro de que quieres cerrar sesión',
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'CANCELAR',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'ACEPTAR',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              if (authentication.googleSignIn.currentUser !=
                                  null) {
                                context
                                    .read<AuthenticationProvider>()
                                    .signOutGoogle();
                              } else {
                                context
                                    .read<AuthenticationProvider>()
                                    .signOutEmail();
                              }
                              Navigator.of(context).pop();
                            } on Exception catch (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Ups, ocurrió una 🥑 (problema)'),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 90,
          ),
        ],
      ),
    );
  }
}
