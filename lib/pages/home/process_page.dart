import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:oficiospe_app_employee/widgets/home/applied_job_item.dart';
import 'package:provider/provider.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Historial de aplicaciones',
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
          FutureBuilder<List<Job>>(
            future: database.getFavoriteJobs(homeProvider.user.appliedJobs),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: List<Widget>.generate(
                    snapshot.data!.length,
                    (index) => AppliedJobItem(
                      appUser: homeProvider.user,
                      job: snapshot.data![index]),
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
