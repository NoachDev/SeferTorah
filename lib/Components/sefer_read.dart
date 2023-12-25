import 'package:flutter/material.dart';

class SeferRead extends StatelessWidget {
  // |-------------------------------------------------------------------------|
  //
  //  Sefer to open ( Arguments )
  //    SeferList : HashMap <String , List > 
  //    String -> Sefer
  //    List -> [ lenght == 0 ? "last perek readed" ] | to the next 
  //
  // |-------------------------------------------------------------------------|

  final Map<String, List<double>> bookMarks ;
  final Function close;

  const SeferRead({
    super.key,
    required this.bookMarks,
    required this.close,

  });

  @override
  Widget build( BuildContext context ){
    return Container(
      width: double.infinity,
      height: double.infinity,

      color: Theme.of(context).colorScheme.background,

      child: Stack(
        children: [
          TopBar(),
          LeftBar(),
          BottomBar(),
          NavegationButtons(),
          Column(
            children: [
              NavegationTop(closeSefer : close),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child : Text(
                    "perek : ahksbasbja",
                    style: TextStyle(
                    fontFamily: "PoiretOne",
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize: 13,
                    inherit: false,
                    letterSpacing: 3
                    )
                  )
                )
              ),

              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, count){
                  return Container();
                },
                itemCount: 1,
              )
            ],
          )
        ],
      )
    ) ;
  }
}

class NavegationButtons extends StatelessWidget {
  const NavegationButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NavegationTop extends StatelessWidget {
  final Function closeSefer;

  const NavegationTop({
    super.key,
    required this.closeSefer,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 58,

        padding: EdgeInsets.all(5),

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

        child: Stack(

          alignment: Alignment.center,
          children: [
            
            Positioned(
              left : 0,
              child :
              IconButton(onPressed: () => closeSefer(), icon: Icon( Icons.close , color: Theme.of(context).colorScheme.background, size : 23 )),
            ),
            
            Center(
              child : Text(
                "Sefer : abcdfgha",
                style: TextStyle(
                  fontFamily: "PoiretOne",
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 20,
                  inherit: false
                ),
              )
            ),

            Positioned(
              right: 0,
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon( Icons.settings , color: Theme.of(context).colorScheme.background, size: 23,)),
                  IconButton(onPressed: (){}, icon: Icon( Icons.menu_rounded , color: Theme.of(context).colorScheme.background, size: 23,)),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LeftBar extends StatelessWidget {
  const LeftBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}