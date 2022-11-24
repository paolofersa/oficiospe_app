import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/pages/job/job_page.dart';
import 'package:oficiospe_app_employee/providers/home_provider.dart';
import 'package:oficiospe_app_employee/services/database.dart';
import 'package:provider/provider.dart';

class JobItem extends StatefulWidget {
  final Job job;

  const JobItem({Key? key, required this.job}) : super(key: key);

  @override
  State<JobItem> createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);

    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobPage(
              job: widget.job,
              worker: homeProvider.user,
            ),
          ),
        );
        setState(() {});
      },
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    widget.job.name,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (homeProvider.user.favoriteJobs
                        .contains(widget.job.id)) {
                      database.removeFavoriteJob(
                        homeProvider.user.id,
                        widget.job.id,
                      );
                      homeProvider.user.favoriteJobs.remove(widget.job.id);
                      homeProvider.changedFavorites();
                    } else {
                      database.addFavoriteJob(
                        homeProvider.user.id,
                        widget.job.id,
                      );
                      homeProvider.user.favoriteJobs.add(widget.job.id);
                    }
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Icon(
                      (homeProvider.user.favoriteJobs.contains(widget.job.id))
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Text(
                'Cantidad de porstulantes ' +
                    widget.job.numApplicants.toString(),
                style: Theme.of(context).textTheme.bodyText1!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
