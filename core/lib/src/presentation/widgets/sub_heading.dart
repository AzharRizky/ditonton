import 'package:core/core.dart' show kHeading6, kRichBlack;
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  const SubHeading({Key? key, this.onTap, required this.title})
      : super(key: key);

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        Material(
          color: kRichBlack,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Text('See More'),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
