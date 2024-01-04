import 'package:flutter/material.dart';

class NavegationButtons extends StatelessWidget {
  final Function getSefer ;

  const NavegationButtons({
    super.key,
    required this.getSefer,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = 18;

    return Positioned(
      left: 20,
      bottom: 20,

      child : Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: iconSize*1.4,

            child : IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  minHeight: iconSize*2.8 ,
                  minWidth: iconSize*2.8 ,
                ),
                onPressed : () => getSefer(1), icon: Icon(Icons.west, size: iconSize), color: Theme.of(context).colorScheme.inverseSurface,
              )
            ),

          SizedBox(width: iconSize/2,),

          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minHeight: iconSize*2.8 ,
              minWidth: iconSize*2.8 ,
            ),
            onPressed: () => getSefer(-1), icon: Icon(Icons.east,
            size: iconSize),
            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
          )
        ],
      )
    );
  }
}

class NavegationTop extends StatelessWidget {
  final Function closeSefer;
  final Function openLefBar;
  final Function openTextConfig;
  final String seferName;

  const NavegationTop({
    super.key,
    required this.closeSefer,
    required this.openLefBar,
    required this.openTextConfig,
    required this.seferName,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: () => closeSefer(), icon: Icon( Icons.close , color: Theme.of(context).colorScheme.inverseSurface, size : 23 )),
      centerTitle: true,
      title: Text(
                seferName,
                style: TextStyle(
                  fontFamily: "PoiretOne",
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontSize: 30,
                  inherit: false
                ),
              ),
      actions: [
          IconButton(onPressed: () => openLefBar(), icon: Icon( Icons.menu_rounded , color: Theme.of(context).colorScheme.inverseSurface, size: 23,)),
          IconButton(onPressed: () => openTextConfig(), icon: Icon( Icons.settings , color: Theme.of(context).colorScheme.inverseSurface, size: 23,)),
          SizedBox(width: 5)

      ],

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
              ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          )
        ),
      )
    );
  }
}
