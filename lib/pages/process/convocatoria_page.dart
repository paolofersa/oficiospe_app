import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/app_user.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/pages/process/applicant_announcement_page.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/provider.dart';

class AnnouncementPage extends StatelessWidget {
  @required
  final Job job;

  @required
  final AppUser appUser;

  const AnnouncementPage({required this.job, required this.appUser, Key? key})
      : super(key: key);

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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Postulantes',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Ocupación',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            FutureBuilder<List<Worker>>(
              future: database.getWorkers(job.applicants),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApplicantAnnouncementPage(
                                job: job,
                                appUser: appUser,
                                worker: snapshot.data![index],
                              ),
                            ),
                          );
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
                                width: width / 2,
                                child: Text(
                                  snapshot.data![index].name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2!,
                                ),
                              ),
                              SizedBox(
                                width: width / 2,
                                child: Text(
                                  snapshot.data![index].profession,
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
            const Divider(),
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
              'Cerrar Convocatoria',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          onPressed: () {
            job.status = 'En seleccion';
            database.updateJob(job.id, job.toMap());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
