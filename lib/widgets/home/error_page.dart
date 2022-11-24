import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final void Function()? onPressed;

  const ErrorPage({
    required this.image,
    required this.title,
    required this.subtitle,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
          child: SvgPicture.asset(
            image,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2),
        ),
        onPressed != null
            ? Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Intenta de nuevo'),
                ),
              )
            : Container(),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
