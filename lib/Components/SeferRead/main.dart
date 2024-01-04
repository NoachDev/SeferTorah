import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:sefertorah/Components/SeferRead/bars.dart';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:sefertorah/Components/SeferRead/navegatiun.dart';
import 'package:path/path.dart' as path;

class SeferRead extends StatelessWidget {
  // |-------------------------------------------------------------------------|
  //
  //  Sefer to open ( Arguments )
  //    SeferList : HashMap <String , List > 
  //    String -> Sefer
  //    List -> [ lenght == 0 ? "last perek readed" ] | to the next 
  //
  // |-------------------------------------------------------------------------|

  final Map<String, Map<String, dynamic>> bookMarks ;
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

      child : PopScope(
        canPop: false,
        onPopInvoked: (didPop){
          if (didPop){
            return;
          }

          close();
        },
        child: SeferView(close: close, bookMarks: bookMarks)
      )
    ) ;
  }
}

class SeferView extends StatefulWidget {
  const SeferView({
    super.key,
    required this.close,
    required this.bookMarks,
  });

  final Function close;
  final Map<String, Map<String, dynamic>> bookMarks;

  @override
  State<SeferView> createState() => _SeferViewState();
}

class _SeferViewState extends State<SeferView> {
  late List seferCharpters;
  late bool viewSefer;
  late String? pathSefer;

  late Map<String, Map<int, String>> bookList;

  late bool textConfig; // hidden = false show bar = true

  late bool vowels; // witch vowels = true, witchout vowels = false
  late bool textLayout; // horizontal = true, vertical = false

  static String translate = "not have translated yet" ;
  static List<String> passukLanguage = ["", ""]; 
  static Map<String, List<String>> requiredTexts = {"comments" : [], "references" : []};
  
  int textLanguage = 2; // hebrew = 0 , another = 1 , hebrew and another = 2

  Map dataConfig = {};

  String pathName = "";
  String seferName = "";
  
  String perekName = "";

  int currentSefer  = 0;
  int currentTab    = 0;
  int currentSpage  = 0;
  int currentCPage  = -1;

  int itemSize      = 25;

  bool visbleLeftBar  = false;
  bool visbleLeftBarC = false;

  static bool visbleBottomBar = false;

  Map<String, dynamic> dataText = {
  };

  String getPath(bool config){
    String filePath =  path.join("assets", "library", viewSefer? "viewLibrary" : "", pathName, viewSefer ? "" : pathSefer, seferName);

    if (config){
      return path.join(filePath, "config.json");
    }
    else{
      return path.join(filePath, "$currentSpage.json");
    }
  }

  void loadJsonFromAssets() async {
    String filePath;

    try {
      String jsonString = await rootBundle.loadString(getPath(false));

      setState(() {
          dataText = jsonDecode(jsonString)["Text"];
          dataConfig["perek"].forEach((key, value){
            if (value.keys.contains(currentSpage.toString()) == true){
                perekName = key;
              }
            }
          );
        }
      );

    } catch (_) {
      
    }
  }

  // get vlues from tree of commands (bookMarks)
  void updateValues(){
    pathName = widget.bookMarks.keys.elementAt(currentTab);
    seferName = widget.bookMarks[pathName]!.keys.elementAt(currentSefer);
    seferCharpters = widget.bookMarks[pathName]![seferName]["charpters"];
    viewSefer = widget.bookMarks[pathName]![seferName]["view"];
    pathSefer = widget.bookMarks[pathName]![seferName]["path"];
  }

  // currentSpage between [0, dataConfig[currentTab]![seferName](number of pages in Sefer)]  
  void addSpage(int page) => currentSpage = dataConfig["pages"] >= currentSpage + page &&  currentSpage + page > 0 ? currentSpage + page : currentSpage;

  // get new Sefer page from de tree of commands (bookMarks) 
  void getSpage() => currentSpage = seferCharpters[currentCPage];

  // clean commands and jump to page
  void goToPage(int page){
    seferCharpters = [];
    addSpage(page - currentSpage);
    loadJsonFromAssets();
  }

  void getSefer(int page){
    if (seferCharpters.isEmpty){
      // if not have commands
      addSpage(page);
    }

    else{
      // back ( page = -1 ) or go to the next ( page = 1 ) command 
      currentCPage = currentCPage + page;

      // if are in the limit of page commands
      if (currentCPage == seferCharpters.length){
        // if are in the limit of command sefers
        if (currentSefer == widget.bookMarks[pathName]!.keys.length){
          // if are in the limit of command tabs
          // continue in the tab and sefer and only go or back new pages 
          if (currentTab == widget.bookMarks.keys.length){
            addSpage(page);
          }
          else{
            // if have more tabs in command tree
            // go to next or previus tab
            // clean offsets ( sefer, pages )
            // and get new sefer page

            currentTab = currentTab + page;
            currentSefer = 0;
            currentCPage = 0;
            updateValues();
            getSpage();
          }
        }
        else{
          // if have more Sefers in command tree
          // go to next or previus Sefer
          // clean offsets ( pages )
          // and get new sefer page

          currentSefer = currentSefer + page;
          currentCPage = 0;
          updateValues();
          getSpage();

        }
      }
      else{
        // if have more pages in command tree
        // go to next or previus page

        getSpage();
      }
    }

    loadJsonFromAssets();
  }

  void openLefBar(){
    setState(() {
      visbleLeftBar = !visbleLeftBar;

      if (visbleLeftBarC == true){
        Future.delayed(Duration(milliseconds: 100)).then((value){
          setState(() {
            visbleLeftBarC = !visbleLeftBarC;
          });
        });
      }
      else{
        visbleLeftBarC = !visbleLeftBarC;
      }
    });

  }

  void changeTextSize(int index){
    setState(() {
      itemSize = 15 + 10*index;
    });
  }   
  
  void openTextConfig(){
    setState(() {
      textConfig = !textConfig;
    });
  }

  void resetSateBars(){
    setState(() {
      textConfig = false;
      
    });
  }

  void vowelsView(int index){
    setState(() {
      vowels = index == 0 ? false : true;
      
    });
  }

  void layoutView(String value){
    setState(() {
      textLayout = value == "h" ? true : false;
      
    });
  }

  void languagesView(int value){
    setState(() {
      print(value);
      textLanguage = value == 0 ? 1 : value == 1 ? 2 : 0 ;
      
    });
  }

  void openBottomBar(update){
    setState((){
      visbleBottomBar = update ? visbleBottomBar : !visbleBottomBar;
    });
  }

  @override
  void initState() {
    super.initState();

    resetSateBars();
    updateValues();

    late String newConfig = getPath(true) ;
    vowels = true;
    textLayout = true;

    rootBundle.loadString(newConfig).then((asset){
      dataConfig = jsonDecode(asset);
      getSefer(1);
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, 58),
              child : NavegationTop(closeSefer : widget.close, seferName : seferName, openLefBar: openLefBar, openTextConfig : openTextConfig),
            ),
            body : Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 45,
                      child: Center(
                        child : Text(
                          "Perek : $perekName",
                          style: TextStyle(
                            fontFamily: "PoiretOne",
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(150),
                            fontWeight: FontWeight.w100,
                            fontSize: 15,
                            inherit: false,
                            letterSpacing: 2
                          )
                      )
                    )
                  ),
                  Expanded(
                    child: TapRegion(
                      onTapInside: (event)=>resetSateBars(),
                      child: SeferText(bookMarks: widget.bookMarks, data : dataText, itemSize: itemSize, voewls: vowels, layout: textLayout, languages : textLanguage, openBottom : openBottomBar),
                    ),
                  ),
                ],
              ),
              
              TopBar(changeSize: changeTextSize, opentextConfig : openTextConfig, textConfig: textConfig, vowelsView : vowelsView, changeLayout : layoutView, changeLanguage : languagesView),

            ],
          ) 
        ),
        NavegationButtons(getSefer: getSefer),
        BottomBar(
          translate : translate,
          passukLanguage : passukLanguage,
          requiredTexts : requiredTexts,
          visible : visbleBottomBar,
          sizeHeight: MediaQuery.of(context).size.height/2.5,
          openBottom : openBottomBar
        ),
        Visibility(
          visible: visbleLeftBarC,
          child : Container(
            color: Colors.transparent,
            child : BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 0.8,
                sigmaY: 0.8
              ),
              child: Stack(
                children: [
                  LeftBar(visible : visbleLeftBar, open: openLefBar,  bookList : dataConfig.isEmpty ? {} : dataConfig["perek"], jumpPage : goToPage),
                ],
              ),
            ),
          )
        ),
        
        
      ],
    );
  }
}

class SeferText extends StatefulWidget {
  final Map<String, Map<String, dynamic>> bookMarks;
  final Map<String, dynamic> data;
  final int itemSize;
  final int languages;
  final bool voewls;
  final bool layout;
  final Function openBottom;
  
  const SeferText({
    super.key,
    required this.bookMarks,
    required this.data,
    required this.voewls,
    required this.layout,
    required this.languages,
    required this.openBottom,
    this.itemSize = 25,
    
  });

  @override
  State<SeferText> createState() => _SeferTextState();
}

class _SeferTextState extends State<SeferText> {

  String numberToCharcter (int number){
    String ret = "" ;
    String num = number.toString();
    int countNum = number;

    Map<int, String> p2p = {
      1   : "א",
      2   : "ב",
      3   : "ג",
      4   : "ד",
      5   : "ה",
      6   : "ו",
      7   : "ז",
      8   : "ח",
      9   : "ט",
      10  : "י",
      20  : "כ",
      30  : "ל",
      40  : "מ",
      50  : "נ",
      60  : "ס",
      70  : "ע",
      80  : "פ",
      90  : "צ",
      100 : "ק",
      200 : "ר",
      300 : "ש",
      400 : "ת"
    };

    for (var i = num.length-1; i >= 0; i --){
      if (i < 3){
        int mul = pow(10, i).toInt();
        int numAbs = (countNum/mul).floor() * mul;
        countNum = countNum - numAbs;

        if (numAbs == 0){
          continue;
        }

        ret = ret + p2p[numAbs]!;
      }
    }
    return ret;
  }
  
  Widget itemBuild(BuildContext context , pageCount){

    if (pageCount == widget.data.keys.length){
      return SizedBox(height: 70);
    }

    String cardName = widget.data.keys.elementAt(pageCount);
    String cardtrad = widget.data[cardName]["pt-br"][0];

    String itemName = numberToCharcter(pageCount+1);

    var itemSizeVert = widget.languages == 2 ? (MediaQuery.of(context).size.width - 100) /2 : (MediaQuery.of(context).size.width - 100);
    List<Widget> itemsWidg = [];

    if (widget.languages != 1){
      itemsWidg.add(SizedBox(
                  width: widget.layout? null : itemSizeVert,
                  child: Text(
                    widget.voewls ? cardName : cardName.replaceAll(RegExp(r'[\u0591-\u05C7]'), ''),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontFamily: "inter",
                      fontWeight: FontWeight.w100,
                      fontSize: widget.itemSize/1.45,
                      inherit: false,
                      ),
                    ),
                ));
    }
    if (widget.languages == 2){
      itemsWidg.add(SizedBox(height: 10, width : 20));
    }

    if (widget.languages >= 1){

      itemsWidg.add(SizedBox(
                    width: widget.layout? null : itemSizeVert,
                    child: Text(cardtrad,
                    textAlign: widget.layout? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200),
                      fontFamily: "inter",
                      fontWeight: FontWeight.w100,
                      fontSize: widget.itemSize/1.65,
                      inherit: false,
                    ),
                ),
                  ));
    }

                  

    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child:  Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(left: 20, bottom: 20),

                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: widget.layout? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: itemsWidg
                    ) : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: itemsWidg
                    ),
                  ),
                )
              ),
              SizedBox(
                width: 60,
                child : Center(
                  child : Text(itemName,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: "inter",
                      fontSize: widget.itemSize - 3*(itemName.length-1),
                      inherit: false,
                    )
                  ) ,
                )
              )
            ],
          ),

          Positioned(
            bottom: 0,
            child: IconButton(onPressed: (){
              var update = _SeferViewState.passukLanguage[0] != cardtrad ? (_SeferViewState.visbleBottomBar? true : false) : false;

              _SeferViewState.passukLanguage = [cardtrad, cardName];
              _SeferViewState.translate = widget.data[cardName]["pt-br"][1];
              
              widget.openBottom(update);
            
            }, icon: Icon(Icons.expand_more)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: itemBuild,
      itemCount: widget.data.keys.length+1,
      
    );
  }
}
