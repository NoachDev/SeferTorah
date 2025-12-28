
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  final String title;
  final Widget leading;
  final String? trailing;
  final Function()? onTap;
  final AlignmentGeometry? edgePosition;

  const PanelButton({
    super.key,
    required this.title,
    required this.leading,
    this.trailing,
    this.onTap,
    this.edgePosition,
  });

  BorderRadiusGeometry getRadius() {
    var radius = BorderRadius.circular(5);
    switch (edgePosition) {
      case Alignment.topCenter:
        radius = BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        );
        break;

      case Alignment.bottomLeft:
        radius = BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(5),
        );
        break;

      case Alignment.bottomRight:
        radius = BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(15),
        );
        break;
    }

    return radius;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: getRadius(),
        ),
      
        height: 50,
        padding: const EdgeInsets.only(left: 15, right: 25),
      
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leading,
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontSize: 12)),
            const Spacer(),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
