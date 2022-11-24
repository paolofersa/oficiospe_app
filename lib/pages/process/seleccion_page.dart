import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/pages/process/applicant_selection_page.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:oficiospe_app_employee/widgets/process/worker_info.dart';
import 'package:provider/provider.dart';

class SelectionPage extends StatefulWidget {
  @required
  final Job job;

  const SelectionPage({required this.job, Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                        widget.job.name,
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
                      widget.job.status,
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                  ],
                )),
            const Divider(),
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width / 3,
                  child: Text(
                    'Postulantes',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
                SizedBox(
                  width: width / 3,
                  child: Text(
                    'Ocupación',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
                SizedBox(
                  width: width / 3,
                  child: Text(
                    'Celular',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Worker>>(
              future: database.getWorkers(widget.job.applicants),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: List<Widget>.generate(
                      snapshot.data!.length,
                      (index) => InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApplicantSelectionPage(
                                job: widget.job,
                                worker: snapshot.data![index],
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: width / 3,
                                child: Text(
                                  snapshot.data![index].name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2!,
                                ),
                              ),
                              SizedBox(
                                width: width / 3,
                                child: Text(
                                  snapshot.data![index].profession,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2!,
                                ),
                              ),
                              SizedBox(
                                width: width / 3,
                                child: Text(
                                  snapshot.data![index].phone,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            widget.job.workerId.isNotEmpty
                ? Column(
                    children: [
                      const Divider(),
                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Text(
                          'Postulante Seleccionado',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color:
                                      const Color.fromRGBO(211, 160, 64, .9)),
                        ),
                      ),
                      FutureBuilder<Worker>(
                        future: database.getworker(widget.job.workerId),
                        builder: (_, snapshot) {
                          if (snapshot.hasError) {
                            return Container();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return WorkerInfo(
                              worker: snapshot.data!,
                              image: widget.job.image,
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  )
                : Container(),
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
              'Cerrar Seleccion',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          onPressed: () {
            widget.job.status = 'Brindado';
            database.updateJob(widget.job.id, widget.job.toMap());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
