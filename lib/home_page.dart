import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {

  final Function openSefer;

  const HomePage({
    super.key,
    required this.openSefer
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size( double.infinity, 58 ),
        child: TopBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SeferLibrary( open : openSefer),
        ]
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final double sizeIcon = 23;

  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: Row(children: [SizedBox(width: 10,), IconButton( onPressed: () {}, icon: Icon(Icons.account_circle_rounded, size: sizeIcon*1.7), color: Theme.of(context).colorScheme.surface,)]),
      leadingWidth: 100,
      
      actions: [
        IconButton( onPressed: () {}, icon: Icon(Icons.search, size: sizeIcon, color: Theme.of(context).colorScheme.inverseSurface)),
        IconButton( onPressed: () {}, icon: Icon(Icons.settings, size : sizeIcon, color: Theme.of(context).colorScheme.inverseSurface,)),
        SizedBox(width: 5)
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 60,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end : Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary
            ]
          )
        ),
      )
    );
  }
}

class SeferLibrary extends StatefulWidget {
  final Function open;

  const SeferLibrary({
    super.key,
    required this.open,

  });

  @override
  State<SeferLibrary> createState() => _SeferLibraryState();
}

class _SeferLibraryState extends State<SeferLibrary> {

  final double radius     = 10; 
  final double tabHeight  = 45;
  final double tabWidth   = 75;
  final double padding    = 10;

  List<Widget> tabWidgets = [];
  List<Widget> tabNames = [];

  void genSefer(){

    rootBundle.loadString("assets/library/viewLibrary/config.json").then((asset){
      var jsonfile = jsonDecode(asset);

      setState(() {
        jsonfile.forEach((key, value){
            tabNames.add(Tab( height: tabHeight, text: key ));
            tabWidgets.add(SeferView(openSefer : widget.open, itemHeight : 35, itemsNames: value, tabName : key ));
        });
      });
    });

  }

  @override
  void initState() {
    super.initState();

    genSefer();
  }

  @override
  Widget build(BuildContext context) {

    final lenghtNames = tabNames.length.toInt();

    return DefaultTabController(
      initialIndex: 0,
      length: lenghtNames,

      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(style: BorderStyle.solid, width: 1, color: Colors.transparent)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
          color: Theme.of(context).colorScheme.surface,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: tabHeight,
              width: lenghtNames*tabWidth,

              child: TabBar(
                dividerColor: Colors.transparent,
                padding: EdgeInsets.only(left: padding),

                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 3)
                ),

                labelPadding: EdgeInsets.symmetric(horizontal: padding/2),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "PoiretOne",
                ),

                tabs: tabNames.reversed.toList()

              )
            ),

            SizedBox(height: padding*1.5),
            
            SizedBox(
              height: 330,
              child: TabBarView(
                children: tabWidgets.reversed.toList(),
              ),
            )
          ],
        ),
      )
    );
  }
}

class SeferView extends StatelessWidget {
  final double itemHeight;
  final List itemsNames;

  final double itemPadding;

  final Function openSefer;
  final String tabName;

  const SeferView({
    super.key,
    required this.openSefer,
    required this.itemHeight,
    required this.tabName,
    this.itemsNames = const [],
    this.itemPadding = 3
  });

  Widget seferWidget( BuildContext context, int pageCount ){
    String seferName = itemsNames[pageCount];
    Map<String, Map<String, dynamic>> seferBookMarks = {};

    return Container(
      width: double.infinity,
      height: itemHeight + itemPadding,
      padding: EdgeInsets.only(bottom: itemPadding),

      child: ElevatedButton(
        onPressed: (){
          seferBookMarks = {
            tabName : {
              seferName : {
                "charpters": [],
                "view" : true
              },
            }

          };

          openSefer(seferBookMarks);
        },

        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder()),
          elevation: MaterialStateProperty.all<double>(0),
        ),

        child: Row(
          children: [
            Icon( Icons.book_sharp, color: Theme.of(context).colorScheme.tertiary, size: itemHeight*0.75),
            SizedBox(width: 20),
            Text(
              seferName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontFamily: "PoiretOne",
                fontSize: 13,
                letterSpacing: 2
              )
            ),
          ],
        ),
      )
    );
  }
  @override
  Widget build( BuildContext context){
    return  ListView.builder(
      itemBuilder: seferWidget,
      scrollDirection: Axis.vertical,
      itemCount: itemsNames.length,
    );
  } 
}
