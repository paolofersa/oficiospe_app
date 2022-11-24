import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:oficiospe_app_employee/widgets/process/worker_info.dart';

class ConcludedPage extends StatelessWidget {
  @required
  final Job job;

  const ConcludedPage({required this.job, Key? key}) : super(key: key);

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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Text(
                'Datos del Trabajo',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: const Color.fromRGBO(211, 160, 64, .9)),
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
                      'Descripción',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                    child: Text(
                      job.description,
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Text(
                      'Beneficios',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                    child: Text(
                      job.benefits,
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Text(
                      'Requerimientos',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    child: Text(
                      job.requirements,
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Divider(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Text(
                    'Datos de quien realizó el trabajo',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color.fromRGBO(211, 160, 64, .9)),
                  ),
                ),
                FutureBuilder<Worker>(
                  future: database.getworker(job.workerId),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return WorkerInfo(
                        worker: snapshot.data!,
                        image: job.image,
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
