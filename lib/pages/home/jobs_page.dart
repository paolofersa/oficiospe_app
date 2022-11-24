import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/pages/job/job_page.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:oficiospe_app_employee/widgets/home/job_item.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trabajos',
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              'Trabajos publicados',
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
          FutureBuilder<List<Job>>(
            future: database.getJobs(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: List<Widget>.generate(
                    snapshot.data!.length,
                    (index) => JobItem(job: snapshot.data![index]),
                  ),
                );
              }
              return Container();
            },
          ),
          ...[
            Container(
              height: 90,
            ),
          ],
        ],
      ),
    );
  }
}
