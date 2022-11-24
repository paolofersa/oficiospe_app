import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/services/database.dart';

class DonePage extends StatelessWidget {
  @required
  final Job job;

  const DonePage({required this.job, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _score = '';

    return Scaffold(
      body: SafeArea(
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
                        job.name,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: const Color.fromRGBO(211, 160, 64, .9)),
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
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Estado Actual',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      job.status,
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                  ],
                )),
            const Divider(),
            FutureBuilder<Worker>(
              future: database.getworker(job.workerId),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Image.network(
                                job.image,
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 8.0),
                              child: Text(
                                'DATOS DEL TRABAJADOR',
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 8.0, 32.0, 8.0),
                              child: Text(
                                snapshot.data!.name,
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 8.0, 32.0, 8.0),
                              child: Text(
                                snapshot.data!.gender,
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 8.0, 32.0, 8.0),
                              child: Text(
                                snapshot.data!.city,
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Calificación General',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyText1!,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return value!.isEmpty ? "Campo vacío" : null;
                            },
                            onSaved: (value) => _score = value!.trim(),
                            controller: TextEditingController(
                              text: job.jobScore.toString(),
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
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
              'Cerrar Brindado',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          onPressed: () {
            final form = _formKey.currentState;
            if (form!.validate()) {
              form.save();
              job.status = 'Concluido';
              job.jobScore = int.tryParse(_score)!;
              database.updateJob(job.id, job.toMap());
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
