import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/app_user.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/src/provider.dart';

class NewJobPage extends StatefulWidget {
  @required
  final AppUser appUser;
  const NewJobPage({required this.appUser, Key? key}) : super(key: key);

  @override
  State<NewJobPage> createState() => _NewJobPageState();
}

class _NewJobPageState extends State<NewJobPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _name = '';
    int _numApplicants = 0;
    String _city = '';
    String _applicationClosing;
    String _description = '';
    String _benefits = '';
    String _requirements = '';

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.arrow_back_ios),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Text(
                          'Nuevo Trabajo',
                          style: Theme.of(context).textTheme.headline5!,
                        ),
                      ],
                    ),
                    const Image(
                      height: 35,
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/oficiospe_logo2.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Nombre del trabajo',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _name = value!.trim(),
                  controller: TextEditingController(
                    text: _name,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Localidad del Trabajo',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _city = value!.trim(),
                  controller: TextEditingController(
                    text: _city,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Fecha de cierre de postulación',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _applicationClosing = value!.trim(),
                  controller: TextEditingController(
                    text: '',
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Descripción del trabajo',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _description = value!.trim(),
                  controller: TextEditingController(
                    text: _description,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Beneficios',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _benefits = value!.trim(),
                  controller: TextEditingController(
                    text: _benefits,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Requerimientos',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _requirements = value!.trim(),
                  controller: TextEditingController(
                    text: _requirements,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
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
                'Cancelar',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.yellow),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
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
                'Guardar',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
            onPressed: () async {
              final form = _formKey.currentState;
              if (form!.validate()) {
                form.save();
                database.addJob(
                  _name,
                  widget.appUser.id,
                  'https://firebasestorage.googleapis.com/v0/b/oficiospe.appspot.com/o/jobs_images%2Fimg3.jpg?alt=media&token=bdd3480f-074e-4ab6-85ff-3d7ad340cc1f',
                  _numApplicants,
                  _city,
                  Timestamp.now(),
                  _description,
                  _benefits,
                  _requirements,
                  'Convocatoria',
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
