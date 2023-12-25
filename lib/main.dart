import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sefertorah/Components/sefer_read.dart';
import 'package:sefertorah/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomBarState()),
      ],
      child : const MyApp()
  )
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: AppScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.white,
            surface: Color.fromARGB(255, 36, 36, 38),
            background: Color.fromARGB(255, 29, 29, 34),
            primary: Color.fromARGB(255, 132,127,224),
            secondary: Color.fromARGB(255, 0,166,195),
            tertiary: Color.fromARGB(255, 63, 161, 117),
            outline: Color.fromARGB(255, 0, 133, 255 ),
          ),
          useMaterial3: true),
        home: Home(),
    );
  }
}

class BottomBarState extends ChangeNotifier {
  var _hidenBottomBar = false;

  void hidenBottomBar(){
    _hidenBottomBar = _hidenBottomBar ? false : true;
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final bodyController = PageController(initialPage: 1);
  Map<String, List<double>> seferBookMark = {};

  int widgetId = 0;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    void openSefer(bookMarks) {
      setState(() {
        widgetId = 1;
        // seferBookMark = bookMarks;
        Provider.of<BottomBarState>(context, listen: false).hidenBottomBar();

      });
    }

    void closeSefer(){
      setState(() {
        seferBookMark = {};
        Provider.of<BottomBarState>(context, listen: false).hidenBottomBar();
        widgetId = 0;

      });
    }

    Widget buildBody(BuildContext context, int countPage){
    switch (currentPage){
      case 0:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return HomePage(openSefer: openSefer);
    }
  }
    void openPage(index){

      if (index == currentPage ){
        return;
      }

      bool ctrl = index > currentPage;
      int page = bodyController.page!.floor() ;

      currentPage = index;

      bodyController.animateToPage( ctrl ?  page +1 : page -1  , duration: Duration(milliseconds: 500), curve : Curves.decelerate );
      
    }


    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child : widgetId == 0 ?
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 70,
              child: 
                PageView.builder(
                controller: bodyController,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: buildBody,
              )
            )
            : SeferRead(bookMarks : seferBookMark, close : closeSefer)
          ),
          NavBottomBar(height: 70, open : openPage),
        ],
      )
    );
  }
}

class IconBottomBar extends StatelessWidget {
  final double size;
  final Function onPrssed;

  const IconBottomBar({
    super.key,
    this.aname = "",
    required this.size,
    required this.onPrssed
  });

  final String aname;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      child: IconButton(
        onPressed: () => onPrssed(),
        highlightColor: Theme.of(context).colorScheme.background,
        hoverColor: Color.fromARGB(20, 255, 255, 255),
        icon: SvgPicture.asset(
          'assets/icons/$aname.svg',
          semanticsLabel: 'book widget',
          height: size*0.60,
          color: Colors.white,
        ),
      )
    );
  }
}

class NavBottomBar extends StatefulWidget {
  final double height;
  final Function open;

  const NavBottomBar({
    super.key,
    required this.height,
    required this.open
  });

  @override
  State<NavBottomBar> createState() => _NavBarState();

}
class _NavBarState extends State<NavBottomBar>{
  double scaleAdd = 1;

  void updatePosAdd(hiden){
    setState(() {
      scaleAdd = hiden ? 0 : 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double iconSize = widget.height*0.4 ;
    bool hiden = Provider.of<BottomBarState>(context)._hidenBottomBar;
    
    return AnimatedPositioned(
      // offset: hiden ? Offset(0, 1) : Offset.zero,
      bottom: hiden ? -widget.height : 0,
      left: 0,

      duration: Duration(seconds: 1),
      curve: Curves.decelerate,
      
      child: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconBottomBar(size : iconSize, aname: "book", onPrssed: (){
                updatePosAdd(true);
                widget.open(0);

                },  ),
              IconBottomBar(size : iconSize, aname: "home", onPrssed: (){updatePosAdd(false); widget.open(1);} ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: scaleAdd == 0 ? 0 : widget.height-6*2,
                width: scaleAdd == 0 ? 0 : widget.height-6*2,
                margin: EdgeInsets.symmetric(horizontal: scaleAdd == 0 ? 0 : 5),

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(widget.height)
                ),
                
                child: AnimatedScale(
                  duration: Duration(milliseconds: 300),
                  scale: scaleAdd,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                    iconSize: scaleAdd == 0 ? 0 : iconSize
                    ),
                  )
                ),
              
              IconBottomBar(size : iconSize, aname: "calendar", onPrssed: (){updatePosAdd(false); widget.open(2);} ),
              IconBottomBar(size : iconSize, aname: "comunity", onPrssed: (){updatePosAdd(false); widget.open(3);} ),
            ]
          )
        )
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}