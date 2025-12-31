import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final String chpterName;
  final String pageName;

  const InfoLabel({
    super.key,

    required this.chpterName,
    required this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // spacing: 15,
      // crossAxisAlignment: WrapCrossAlignment.center,
      // alignment: WrapAlignment.center,
      // direction: Axis.horizontal,
      children: [
        Positioned(
          right: MediaQuery.of(context).size.width / 2 + 16,
          child: Text(
            "Capitulo : $chpterName",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            height: 25,
          ),
        ),
        Positioned(
          left:  MediaQuery.of(context).size.width / 2 + 16,
          child: Text(pageName)),
      ],
    );
  }
}
