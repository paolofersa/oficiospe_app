import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/providers/authentication_provider.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/src/provider.dart';

class EditProfilePage extends StatefulWidget {
  @required
  final Worker appUser;

  const EditProfilePage({required this.appUser, Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authUser = context.read<AuthenticationProvider>().user;
    String _name = '';
    String _lastName = '';
    String _phone = '';
    String _city = '';
    String _profession = '';
    String _age = '';
    String _gender = '';
    String _knowledges = '';

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
                          'Editar perfil',
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
                  'Nombre',
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
                    text: widget.appUser.name,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Apellido',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _lastName = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.lastName,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Profesión',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _profession = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.profession,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Conocimientos',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _knowledges = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.gender,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Celular',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _phone = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.phone,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Ciudad',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _city = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.city,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Edad',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _age = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.age.toString(),
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Sexo',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Campo vacío" : null;
                  },
                  onSaved: (value) => _gender = value!.trim(),
                  controller: TextEditingController(
                    text: widget.appUser.gender,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
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
                      if (_name != widget.appUser.name ||
                          _lastName != widget.appUser.lastName ||
                          _phone != widget.appUser.phone ||
                          _city != widget.appUser.city ||
                          _profession != widget.appUser.profession ||
                          _age != widget.appUser.age.toString() ||
                          _gender != widget.appUser.gender) {
                        database.updateWorker(
                          authUser!.uid,
                          {
                            'name': _name,
                            'last_name': _lastName,
                            'phone': _phone,
                            'city': _city,
                            'profession': _profession,
                            'gender': _gender,
                            'age': int.parse(_age),
                            'knowledges': _knowledges,
                          },
                        );
                        widget.appUser.name = _name;
                        widget.appUser.lastName = _lastName;
                        widget.appUser.phone = _phone;
                        widget.appUser.city = _city;
                        widget.appUser.profession = _profession;
                        widget.appUser.gender = _gender;
                        widget.appUser.age = int.parse(_age);
                        widget.appUser.knowledges = _knowledges;
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
