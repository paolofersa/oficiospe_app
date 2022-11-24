import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/provider.dart';

class ApplicantSelectionPage extends StatefulWidget {
  @required
  final Job job;

  @required
  final Worker worker;

  const ApplicantSelectionPage(
      {required this.job, required this.worker, Key? key})
      : super(key: key);

  @override
  State<ApplicantSelectionPage> createState() => _ApplicantSelectionPage();
}

class _ApplicantSelectionPage extends State<ApplicantSelectionPage> {
  @override
  Widget build(BuildContext context) {
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
                        widget.worker.name,
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
                      'DATOS GENERALES',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Usuario desde:',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          Text(
                            widget.worker.enrollmentDate.toDate().toString(),
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Edad:',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          Text(
                            widget.worker.age.toString(),
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Sexo:',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          Text(
                            widget.worker.gender,
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Localidad de residencia:',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          Text(
                            widget.worker.city,
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Celular de contacto:',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          Text(
                            widget.worker.phone,
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ],
                      )),
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
                      'DETALLES',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Text(
                      'Habilidades y conocimientos',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                    child: Text(
                      widget.worker.knowledges,
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                ],
              ),
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
              'Seleccionar Postulante',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          onPressed: () {
            widget.job.workerId = widget.worker.id;
            database.updateJob(widget.job.id, widget.job.toMap());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
