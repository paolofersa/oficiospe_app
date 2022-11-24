import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileItem({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1!,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyText1!,
          ),
        ),
      ],
    );
  }
}
