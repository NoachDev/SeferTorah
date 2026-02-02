import 'dart:math';

import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final String chapterName;
  final String pageName;

  const InfoLabel({
    super.key,

    required this.chapterName,
    required this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    final padRight = (chapterName.length - pageName.length + 10) * 1.5;

    return Padding(
      padding: EdgeInsets.only(right: max(padRight, 0)),
      child: Wrap(
        spacing: 15,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text(
            "Capitulo : $chapterName",
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            height: 25,
          ),
          Text(pageName),
        ],
      ),
    );
  }
}
