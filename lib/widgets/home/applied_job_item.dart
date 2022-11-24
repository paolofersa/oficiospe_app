import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/app_user.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/pages/job/job_page.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/provider.dart';

class AppliedJobItem extends StatefulWidget {
  @required
  final Job job;

  @required
  final Worker appUser;

  const AppliedJobItem({Key? key, required this.appUser, required this.job}) : super(key: key);

  @override
  State<AppliedJobItem> createState() => _AppliedJobItemState();
}

class _AppliedJobItemState extends State<AppliedJobItem> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);

    return Container(
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
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    widget.job.name,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Text(
                    'Estado actual del trabajo ',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Text(
                    widget.job.status,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Text(
                    'Contratado ',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
                (widget.job.status == 'Brindado' || widget.job.status == 'Concluido') ?
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Text(
                    widget.job.workerId == widget.appUser.id ? 'SI' : 'NO',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                )
                :
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Text(
                    'Pendiente',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}
