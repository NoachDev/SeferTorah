import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  final String translate;
  final List<String> passukLanguage; 
  final Map<String, List<String>> requiredTexts;
  final bool visible;
  final double sizeHeight;
  final Function openBottom;

  const BottomBar({
    super.key,
    required this.translate,
    required this.passukLanguage,
    required this.requiredTexts,
    required this.visible,
    required this.sizeHeight,
    required this.openBottom,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var selectedLanguage = [true, false];
  var _controllerPage = PageController(initialPage: 0, viewportFraction: 1);
  var _cardRef = false;
  var _drag = false;
  double posy = 0;

  void toPage(bool ref, ){
    _cardRef = ref;
    _controllerPage.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
  }

  Widget itemBuild( BuildContext context, int pageCount){
    
    if (pageCount == 1){
      if (_cardRef){
        return Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){_controllerPage.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);}, icon: Icon(Icons.chevron_left))
                ],
              )
            ],
        );
      }

      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  IconButton( alignment: Alignment.topLeft, padding: EdgeInsets.all(10) ,onPressed: (){_controllerPage.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);}, icon: Icon(Icons.chevron_left)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top : 10.0),
                      child: Text("Passuk {1}", style: TextStyle(
                        fontFamily: "Ruthie",
                        inherit: false,
                        fontSize: 35,
                        height: 1,
                        letterSpacing: 3
                      ),
                                        ),
                    ) 
              
                  )
                ],
              
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal : 20),
              
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 30),
                  itemBuilder: (context, index){
                    if (index % 2 > 0){
                      return Divider();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Author : not maked yet (1, 0-0)",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.6),
                                fontFamily: "inter",
                                fontWeight: FontWeight.w100,
                                fontSize: 15,
                                inherit: false,
                              ),
                            ),
                            Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.local_library, color: Color.fromARGB(255, 127,225,181),)))
                          ],
                        ),
                        Text(
                            'זו תכונה שעדיין לא יושמה, אבל כאן אתה הולך לראות את ההערות של מחברים כמו (רש"י, ועוד של אחרים)',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.inverseSurface,
                              fontFamily: "inter",
                              fontWeight: FontWeight.w100,
                              fontSize: 25/1.45,
                              inherit: false,
                            ),
                          ),
                        SizedBox(height: 10,),
                        Text(
                            "this is a feature not implemented yet, but here is where you go view the comments of authors like a ( Rashi, radak, mailbin and another's )",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200),
                              fontFamily: "inter",
                              fontWeight: FontWeight.w100,
                              fontSize: 25/1.65,
                              inherit: false,
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                
                    );
                  },
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                
                ),
              ),
            )
          ]
      );
    }

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal : 20.0, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () => {}, padding: EdgeInsets.all(2) ,icon: SvgPicture.asset('assets/icons/audioWave.svg',
                  semanticsLabel: 'audioWave',
                  width: 40,
                )
              ),
              Expanded(
                child: Text(
                  widget.translate,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    inherit: false,
                    fontWeight: FontWeight.w100,
                    height: 1,
                  ),
                ),
              )
            ],
          ),
          
          CardPage(openPage: () => toPage(false), outLine: Theme.of(context).colorScheme.tertiary, titleText: "Cometarys"),
          CardPage(openPage: () => toPage(true), outLine: Theme.of(context).colorScheme.primary, titleText: "references"),
          
          Expanded(child: Container(),),
          
          Row(
            children: [
              IconButton(onPressed: (){
                String text = "";

                if (selectedLanguage[0]){
                  text += widget.passukLanguage[0];
                }

                if (selectedLanguage[1]){
                  text += widget.passukLanguage[1];
                }

                Clipboard.setData(
                  ClipboardData(text: text)
                );
                
              }, icon: Icon(Icons.content_copy)),
              SizedBox(width: 15,),
              ToggleButtons(
                constraints: const BoxConstraints(
                    minHeight: 50.0,
                    minWidth: 80.0,
                ),
      
                onPressed: (int index) {
                  // All buttons are selectable.
                  setState(() {
                    selectedLanguage[index] = !selectedLanguage[index];
                  });
                },
      
                borderRadius: BorderRadius.circular(10),
                direction: Axis.horizontal,
                selectedColor: Colors.white,
                fillColor: Theme.of(context).colorScheme.outline,
                isSelected: selectedLanguage,
      
                children: [
                  Text("another"),
                  Text("hebrew")
                ],
              )
            ],
          ),
          Expanded(child: Container(),),
          Row(
            children: [
              IconButton(onPressed: ()=>{}, icon: Icon(Icons.share)),
              SizedBox(width: 15,),
              Text("Share the passuk",textAlign: TextAlign.left, style: TextStyle(
                fontFamily: "PoiretOne",
                inherit: false,
                fontSize: 15,
                height: 1,
              ),)
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    posy = -widget.sizeHeight;
  }
  @override
  Widget build(BuildContext context) {
    if (!_drag ){
      if (widget.visible){
        posy = 0;
      }
      else{
        posy = -widget.sizeHeight;
      }
    }

    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      bottom: posy,

      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          _drag = true;

          setState(() {
            posy = min(-details.localPosition.dy, 0);
            
          });
        },
        onVerticalDragEnd: (details){
          
          _drag = false;

          if(posy <= - widget.sizeHeight /2){
            widget.openBottom(false);
          }
          else{
            setState(() {
              posy = -widget.sizeHeight ;
              
            });

          }
        },
        child: TapRegion(
          onTapOutside: (event) {
            setState(() {
              posy = -widget.sizeHeight ;
            });
          },
          child : Container(
            height: widget.sizeHeight ,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        
            ),
        
            child: Column(
              children: [
                Container(height: 2, width: 40, margin: EdgeInsets.only( top : 20, bottom: 10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),),
        
                Expanded(
                  child: PageView.builder(
                    controller: _controllerPage,
                    itemBuilder: itemBuild,
                    itemCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardPage extends StatelessWidget {
  final Color outLine ;
  final String titleText ;
  final Function openPage ;

  const CardPage({
    super.key,
    required this.outLine,
    required this.titleText,
    required this.openPage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: outLine, width: 1)),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.background,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          onTap: () => openPage(),
          visualDensity: VisualDensity.compact,
          title: Text(titleText),
          trailing: Icon(Icons.chevron_right),
          dense: true,
        ),
      ),
    );
  }
}

class LeftBar extends StatelessWidget {
  final bool visible;
  final Function open;
  final Function jumpPage;
  final dynamic bookList;

  const LeftBar({
    super.key,
    required this.visible,
    required this.open,
    required this.jumpPage,
    this.bookList = const {}
  });

  @override
  Widget build(BuildContext context) {
    Color inverese = Theme.of(context).colorScheme.inverseSurface;
    double sizeBar = MediaQuery.of(context).size.width/1.3;
    
    Widget buildItemList( BuildContext context, int pageCount){
      String name = bookList.keys.elementAt(pageCount);

      List<Widget> ret = [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Text(
            name,
            style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            inherit: false,
            fontFamily: "PoiretOne",
            fontSize: 18,
          ),
          ),
        )
      ];


      bookList[name]!.forEach((String key, value){
        ret.add(
          Container(
            margin: EdgeInsets.only(left: 40, bottom: 0, right: 10),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Color.fromARGB(255, 127,225,181), width: 3))
            ),
            child : TextButton(
              onPressed: (){
                jumpPage(int.parse(key));
                open();
              },
              child: Text(
                "charpter $key : $value",
                style: TextStyle(
                color: inverese,
                inherit: false,
                fontFamily: "PoiretOne",
                fontSize: 15,
              ),
              ),

            )
          )
        );
      });

      ret.add(
        Padding(
          padding: EdgeInsets.only(bottom: 20),
        )
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ret
      );
    }

    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      right: visible ? 0 : - sizeBar,

      child: Container(
        width: sizeBar,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.surface,
        child : TapRegion(
          onTapOutside: (event) => open(),
          child: Stack(
          children: [

            Padding(
              padding: EdgeInsets.only(top : MediaQuery.of(context).padding.top),
              child: ListView.builder(
                itemBuilder : buildItemList,
                itemCount: bookList.keys.length,
                padding: EdgeInsets.only(top : 58),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border(bottom: BorderSide(color: inverese, width: 1))
              ),
              child: SizedBox(
                width: sizeBar,
                height: 58 + MediaQuery.of(context).padding.top-1,
              ),
            ),
            ClipRect(
              child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 3,
                    sigmaY: 3
                  ),
                  child : SizedBox(
                    width: sizeBar,
                    height: 58 + MediaQuery.of(context).padding.top-1,
                    child: Padding(
                      padding: EdgeInsets.only(top : MediaQuery.of(context).padding.top),
                      child : Center(
                      child : Text(
                        "Charpters",
                        style: TextStyle(
                            color: inverese,
                            inherit: false,
                            fontFamily: "PoiretOne",
                            fontSize: 18,
                          ),
                        )
                      )
                    )
                  )
              ),
            )
            
          ],
        )
        )
        
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Function changeSize;
  final Function opentextConfig;
  final Function vowelsView;
  final Function changeLayout;
  final Function changeLanguage;
  final bool textConfig;

  const TopBar({
    super.key,
    required this.changeSize,
    required this.textConfig,
    required this.opentextConfig,
    required this.vowelsView,
    required this.changeLayout,
    required this.changeLanguage,
  });

  @override
  Widget build(BuildContext context) {
    var structHeight = MediaQuery.of(context).size.height/3.7;
    var iconHeight = structHeight/6;

    return AnimatedPositioned(
      top: textConfig ? 0 : -structHeight,
      duration: Duration(milliseconds: 250),

      child: Container(
        height: structHeight,
        width : MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal : 20.0, vertical: 20),
          child: Row(
            children: [
              
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text("text size", style: TextStyle(
                    fontFamily: "PoiretOne",
                    fontSize: 18
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left : 13.0, top: 13),
                    child: SwitchWidget(funcSwitich: changeSize, bodyColor : Theme.of(context).colorScheme.primary, itemHeight: iconHeight, itemDisplay: List.generate(3, (index) => "A"), itemFonts: [12, 16, 20],),
                  ),
                  SizedBox(height: 20,),
                  Text("Languages Displayed", style: TextStyle(
                    fontFamily: "PoiretOne",
                    fontSize: 18
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left : 5.0, top: 13),
                    child: Row(
                      children: [
                        SwitchWidget(funcSwitich: (index)=>changeLanguage(index), bodyColor : Theme.of(context).colorScheme.background, itemDisplay: ["A", "Aא", "א"], itemWidth: 40, itemHeight: iconHeight, indicator: false,),
                        SizedBox(width: 15,),
                        DDownLayout(changeLayout: changeLayout,)
                      ],
                    ),
                  )
                ],
              ),
              Expanded(child: Container(),),

              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text("vowels", style: TextStyle(
                    fontFamily: "PoiretOne",
                    fontSize: 18
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left : 13.0, top: 13),
                    child : SwitchWidget(funcSwitich: (index) => vowelsView(index), bodyColor : Theme.of(context).colorScheme.background.withOpacity(0.8), itemHeight: iconHeight, itemDisplay: ["א", "אָ"], indicator: true,)
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("comentarys", style: TextStyle(
                        fontFamily: "PoiretOne",
                        fontSize: 18
                      ),),

                      SizedBox(width: 20,),

                      SizedBox(
                        width: 50,
                        height: 25,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(
                          activeColor: Theme.of(context).colorScheme.outline,
                          value: true,
                          onChanged: (value){},
                          
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("WordsView", style: TextStyle(
                        fontFamily: "PoiretOne",
                        fontSize: 18
                      ),),

                      SizedBox(width: 20,),

                      SizedBox(
                        width: 50,
                        height: 25,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(
                          activeColor: Theme.of(context).colorScheme.outline,
                          value: true,
                          onChanged: (value){},
                          
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DDownLayout extends StatefulWidget {
  final Function changeLayout;

  const DDownLayout({
    super.key,
    required this.changeLayout,
  });

  @override
  State<DDownLayout> createState() => _DDownLayoutState();
}

class _DDownLayoutState extends State<DDownLayout> {
  String selectedIndex = "h";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (value){
        setState(() {
          selectedIndex = value!;
        });

        widget.changeLayout(selectedIndex);
      },
      value: selectedIndex,
      underline: Container(),
      items: [
        DropdownMenuItem( value: "h", child: SvgPicture.asset(
          'assets/icons/aliginHorizontal.svg',
          semanticsLabel: 'book widget',
          color: Colors.white,
          
        )),
        DropdownMenuItem( value: "v", child: SvgPicture.asset(
          'assets/icons/aliginVertical.svg',
          semanticsLabel: 'book widget',
          color: Colors.white,
        )),
      ],
    
    );
  }
}

class SwitchWidget extends StatefulWidget {
  final Function funcSwitich;
  final bool indicator;
  final double itemHeight;
  final double itemWidth;
  final Color bodyColor;
  final List<String> itemDisplay;
  final List<double> itemFonts;

  const SwitchWidget({
    super.key,
    required this.funcSwitich,
    required this.itemDisplay,
    this.indicator = true,
    this.bodyColor = Colors.amber,
    this.itemHeight = 36,
    this.itemWidth = 36,
    this.itemFonts = const [],
  });

  @override
  State<SwitchWidget> createState() => _SwitchState();
}

class _SwitchState extends State<SwitchWidget> {

  double indexPadL = 15;
  int indexCtrl = 1;

  void changeIndcator(index){
    setState(() {
      indexCtrl = index;
      indexPadL = 15+widget.itemWidth*index;
    });

    widget.funcSwitich(index);
  }

  List<Widget> itemSize(){
    List<Widget> ret = [];
    for (int i = 0; i < widget.itemDisplay.length; i++){
      ret.add(
        SizedBox(
          width: widget.itemWidth,
          height: widget.itemHeight,
          child : TextButton(
            onPressed: () => changeIndcator(i),
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                inherit: false,
                height: 1,
                overflow: TextOverflow.clip,
                fontFamily: "Ruthie",
                
                fontSize: widget.itemFonts.isEmpty ? null : widget.itemFonts.elementAt(i),
              )
            ),
            child: Center(
              child: Text(
                widget.itemDisplay[i],
                softWrap: false,
                style: TextStyle(
                  color: widget.indicator ? Theme.of(context).colorScheme.inverseSurface : i == indexCtrl ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                )
              ),
            )
          )
        ),
      );
    }

    return ret;
  }

  @override
  void initState() {
    super.initState();

    indexPadL = 15+widget.itemWidth;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> conteins = [
      
    ];

    if (widget.indicator){
      conteins.add(
        AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: indexPadL,
            child: Container(
              width: widget.itemWidth,
              height: widget.itemHeight,
              color: Colors.white.withOpacity(0.15),
            )
        )
      );
    }

    conteins.add(
      Center(
            child: SizedBox(
              height: widget.itemHeight,
              width : widget.itemWidth*widget.itemDisplay.length,
              child: Row(
                children: itemSize()
              ),
            ),
          ),
    );

    return Container(
      decoration: BoxDecoration(
        color: widget.bodyColor,
        borderRadius: BorderRadius.circular(20)
      ),
      width: widget.itemWidth*widget.itemDisplay.length+30,
      height: widget.itemHeight,
      alignment: Alignment.center,
      child : Stack(
        children: conteins
      )
    
        
      );
  }
}




