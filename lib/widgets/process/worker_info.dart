import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/worker.dart';

class WorkerInfo extends StatelessWidget {
  @required
  final Worker worker;
  @required
  final String image;
  const WorkerInfo({required this.worker, required this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'DATOS DEL TRABAJADOR',
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
            child: Text(
              worker.name,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
            child: Text(
              worker.gender,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
            child: Text(
              worker.city,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
        ],
      ),
    );
  }
}
