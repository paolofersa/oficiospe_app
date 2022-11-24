import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/app_user.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  @required
  final Job job;

  @required
  final Worker worker;

  const JobPage({required this.job, required this.worker, Key? key})
      : super(key: key);

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<AppUser>(
          future: database.getUser(widget.job.userId),
          builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
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
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        widget.job.image,
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 11.5, 16.0, 8.0),
                      child: Text(
                        'DATOS DEL EMPLEADOR',
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Text(
                        snapshot.data!.name,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Text(
                        snapshot.data!.city,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Text(
                        snapshot.data!.employerType,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
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
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                      child: Text(
                        'DATOS DEL TRABAJO',
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: Text(
                        'Descripción',
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Text(
                        widget.job.description,
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
                        widget.job.benefits,
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
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: Text(
                        widget.job.requirements,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
              }
              return Container();
            },
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
                widget.worker.favoriteJobs.contains(widget.job.id)
                    ? 'Quitar de Favoritos'
                    : 'Agregar de Favoritos',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
            onPressed: () async {
              if (widget.worker.favoriteJobs.contains(widget.job.id)) {
                database.removeFavoriteJob(
                  widget.worker.id,
                  widget.job.id,
                );
                widget.worker.favoriteJobs.remove(widget.job.id);
              } else {
                database.addFavoriteJob(
                  widget.worker.id,
                  widget.job.id,
                );
                widget.worker.favoriteJobs.add(widget.job.id);
              }
              setState(() {});
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
                'Postular Ahora',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
            onPressed: () {
              database.postulate(widget.worker.id, widget.job.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
