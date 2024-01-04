import 'package:flutter/material.dart';

class TanakhPage extends StatefulWidget{
  final Function openSefer;

  const TanakhPage({
    super.key,
    required this.openSefer
  });


  @override
  State<TanakhPage> createState() => _TanakhPageState();
}

class _TanakhPageState extends State<TanakhPage> {
  late String seferName;
  late Map<String, String > seferContent;

  double index = 0;
  PageController _controller = PageController(initialPage: 0);
  
  List<Widget> buttonsSlide(color){
    List<Widget> ret = [];

    for (double i = 0; i < 3 ; i ++){
      ret.add(
          TapRegion(
            onTapInside: (event){
              _controller.animateToPage(i.toInt(), duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
            },
            child: Container(
            width : 10,
            height: 10,
            margin: EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              color: i == index? color : Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(10)
            ),
                    ),
          ),
      );
    }

    return ret;
  }
  
  Widget cardsBuild(BuildContext context, int pageCount){
    String name = seferContent.keys.elementAt(pageCount);

    return
      Row(
        children: [
          Text(name, style: TextStyle(
            inherit: false,
            fontSize: 18,
            // fontFamily: "Ruthie",
            fontFamily: "PoiretOne",
            fontWeight: FontWeight.w100,
            letterSpacing: 1
          ),),
          SizedBox(width: 20,),
          Expanded(
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.background,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                onTap: (){

                    // changePage();
                    index = _controller.page!.toDouble();
                    changePage();

                    Map<String, Map<String, dynamic>> bookMark = {
                      "_tanakh" : {
                        name.toLowerCase() : {
                          "charpters": [],
                          "view" : false,
                          "path" : seferName.toLowerCase()

                        },
                      }
                    };

                    widget.openSefer(bookMark);
                  },
                visualDensity: VisualDensity.compact,
                title: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 3, bottom: 3),
                  child: Text(seferContent[name]!, style: TextStyle(
                    inherit: false,
                    fontSize: 15,
                    // fontFamily: "Ruthie",
                    fontFamily: "PoiretOne",
                    fontWeight: FontWeight.w100,
                    color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200)
                  ),),
                ),
                trailing: Icon(Icons.chevron_right, color: Color.fromARGB(255, 127,225,181),),
                dense: true,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget buildPage(BuildContext context, int pageCount){
    if (index != pageCount){
      index = pageCount.toDouble();
      changePage();
    }
    return ListView.builder(
      itemBuilder: cardsBuild,
      itemCount: seferContent.length,
      padding: EdgeInsets.symmetric(vertical: 50),
      physics: NeverScrollableScrollPhysics(),

    );
  }
  
  void changePage(){
    switch (index){
      case 1 :
        seferName = "Neviim";
        seferContent = {
          "reis aleph" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Commodo nulla facilisi nullam vehicula ipsum"
        };

      case 2 :
        seferName = "Ketuvim";
        seferContent = {
          "thilim" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Commodo nulla facilisi nullam vehicula ipsum "
        };

      default :
        seferName = "Romash";
        seferContent = {
          "Bereshit" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Commodo nulla facilisi nullam vehicula ipsum."
        };
    }
  }  

  @override
  void initState() {
    super.initState();
    changePage();
  }

  @override
  Widget build( BuildContext context ){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 58),
        child: AppBar(
          title: Text(seferName, style: TextStyle(
            inherit: false,
            fontSize: 20,
            fontFamily: "PoiretOne",
            fontWeight: FontWeight.w100,
            letterSpacing: 2
          ),),

          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 60,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
          )
        ),
      ),
      
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
        
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left : 20.0),
              child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
                itemBuilder: buildPage,
                itemCount: 3,
                onPageChanged: (page){
                  setState(() {
                    index = page.floor().toDouble();
                    changePage();
                  });
                },
                physics: BouncingScrollPhysics(),
              ),
            )
          ),
          
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttonsSlide(Theme.of(context).colorScheme.outline),
            ),
          )
        ],
        
            ),
      ) ,
    );
  }
}