import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AppRelatedData.dart';
import 'package:flutter_app/Model.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

AnimationController controller, controller2;
Animation<Offset> offset, offset2;
var navigator;
Model emrDataList;
Future<Model> fetchEMRdata;
final Map<String, int> someMap = {};
var namesList = List();
var symptomsList = List();

void main() => runApp(MyApp());
bool _saving = false;
var topBarVisibility = true;
var sideBarVisibility = false;
AppRelatedData appRelatedData = AppRelatedData();
String selectedReason = appRelatedData.durationType[0].type;
String selectedReasonId = appRelatedData.durationType[0].typeId;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'EMR R and D'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    fetchEMRdata = getEMRdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: FutureBuilder<Model>(
        future: fetchEMRdata,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: navigator,
          );
        },
      ),
    );
  }

  Future<Model> getEMRdata() async {
    Response response = await get("https://api.myjson.com/bins/12kfjm");
//    Response response =
//        await get("http://qurix.ai:8080/qurix_uat/openapi/orginfo/"
//            "getlocations?seuuid=b31e2a35-eab4-47c3-9493-327d47673ebc");
    emrDataList = Model.fromJson(jsonDecode(response.body));
    // print("emrdata" + emrDataList.toString());
    setState(() {
      _saving = true;
      for (var item in emrDataList.symptoms) {
        symptomsList.add(item.name);
      }
      navigator = symptomsWidget(symptomsList);
    });
    return emrDataList;
  }
}

class symptomsWidget extends StatefulWidget {
  List symptoms;

  symptomsWidget(this.symptoms);

  @override
  _symptomsWidgetState createState() => _symptomsWidgetState();
}

class _symptomsWidgetState extends State<symptomsWidget>
    with TickerProviderStateMixin {
  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> reasonsList = [];
    List reasonsIds = [];
    for (int i = 0; i < appRelatedData.durationType.length; i++) {
      var newItem = DropdownMenuItem(
        child: Text(
          appRelatedData.durationType[i].type,
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        value: appRelatedData.durationType[i].type,
      );
      reasonsList.add(newItem);
      reasonsIds.add(appRelatedData.durationType[i].typeId);
    }

    return DropdownButton<String>(
      value: selectedReason,
      items: reasonsList,
      icon: Icon(Icons.keyboard_arrow_down),
      underline: Divider(
        color: Colors.white,
        height: 1,
        thickness: 1,
      ),
      style: new TextStyle(
        color: Colors.black,
      ),
      onChanged: (value) {
        setState(() {
          selectedReason = value;
        });
        print("selectedReasonID:  " + selectedReasonId);
      },
    );
  }

  int actualIndex;

  String selectedSymptom = "";

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ));
    controller2 = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 150,
        ));

    offset = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller);

    offset2 = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller2);

    //controller.forward();
    //controller2.forward();
//    setState(() {
//      topNavigator = topBar();
//      sideNavigator = Container();
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //SideBar(),
        SlideTransition(
          position: offset2,
          child: Visibility(
            visible: sideBarVisibility,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    width: 80,
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              sideBarVisibility = false;
                              topBarVisibility = true;
                            });
                            controller2.reverse();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SideBarButton("All", 1),
                        SideBarButton("Sym", 2),
                        SideBarButton("GE", 3),
                        SideBarButton("RS", 4),
                        SideBarButton("CVS", 5),
                        SideBarButton("CNS", 6),
                        SideBarButton("P/A", 7),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        //sideNavigator,
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              //topBar(),
              Visibility(
                visible: topBarVisibility,
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            topBarVisibility = false;
                            sideBarVisibility = true;
                          });
                          controller2.forward();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.menu),
                        ),
                      ),
                      Text(
                        'Symptoms',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Findings',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100.0),
                        child: Text(
                          'All',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //topNavigator,
              Expanded(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SearchBox(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: namesList.length == 0
                              ? 0
                              : (namesList.length <= 4
                                  ? 100
                                  : namesList.length / 4 * 100),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: namesList.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 4 / 2,
                                            crossAxisCount: 4),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              top: 15,
                                              bottom: 15,
                                              right: 10),
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xffC90144),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white,
                                                  style: BorderStyle.solid)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedSymptom =
                                                        namesList[index];
                                                    controller.forward();
                                                  });
                                                },
                                                child: Text(
                                                  namesList[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (var entry
                                                        in someMap.entries) {
                                                      if (entry.key ==
                                                          namesList[index]) {
                                                        if (entry.value <=
                                                            widget.symptoms
                                                                .length) {
                                                          actualIndex =
                                                              entry.value;
                                                        } else {
                                                          actualIndex = widget
                                                              .symptoms.length;
                                                        }
                                                      }
                                                    }

                                                    widget.symptoms.insert(
                                                        actualIndex,
                                                        namesList[index]);
                                                    namesList.removeAt(index);
                                                    controller.reverse();
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                          itemCount: widget.symptoms.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 4 / 2, crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    someMap[widget.symptoms[index]] = index;
                                    namesList.add(widget.symptoms[index]);
                                    selectedSymptom = widget.symptoms[index];
                                    controller.forward();
                                    widget.symptoms.removeAt(index);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFF2F7),
                                    border: Border.all(
                                      color: Color(0xffC90144),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                  child: Text(widget.symptoms[index],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SlideTransition(
            position: offset,
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        Expanded(
                          child: selectedSymptom == ""
                              ? Center(child: Text("------"))
                              : Center(
                                  child: Text(
                                  selectedSymptom,
                                  style: TextStyle(fontSize: 18),
                                )),
                        ),
                        FlatButton(
                          onPressed: () {
                            controller.reverse();
                          },
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                    child: Container(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type a note here'),
                                ),
                              ),
                            ),
                            Icon(Icons.search),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 10),
                    child: Text(
                      'Duration',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      width: 605,
                      height: 101,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              DurationItem("1d"),
                              DurationItem("2d"),
                              DurationItem("3d"),
                              DurationItem("4d"),
                              DurationItem("5d"),
                              DurationItem("6d"),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                            child: Container(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              DurationItem("1w"),
                              DurationItem("10d"),
                              DurationItem("2w"),
                              DurationItem("3w"),
//                              DurationItem("5d"),
//                              DurationItem("6d"),
                              Flexible(
                                child: Container(
                                  width: 120,
                                  margin: EdgeInsets.only(left: 10, right: 20),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter days"),
                                  ),
                                ),
                              ),
                              androidDropdown(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DurationItem extends StatefulWidget {
  String item;
  DurationItem(this.item);

  @override
  _DurationItemState createState() => _DurationItemState();
}

class _DurationItemState extends State<DurationItem> {
  double wwidth = 99.5;
  double hheight = 49;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wwidth,
      height: hheight,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 37.0, right: 37),
            child: Text(
              widget.item,
              style: TextStyle(
                  fontSize: widget.item == "1w" ||
                          widget.item == "10d" ||
                          widget.item == "2w" ||
                          widget.item == "3w"
                      ? 12
                      : 12),
            ),
          ),
          SizedBox(
            width: widget.item == "6d" ? 0 : 1,
            height: hheight,
            child: Container(
              color: Colors.grey.shade300,
            ),
          )
        ],
      ),
    );
  }
}

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset2,
      child: Visibility(
        visible: sideBarVisibility,
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        sideBarVisibility = false;
                        topBarVisibility = true;
                      });
                      controller2.reverse();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SideBarButton("All", 1),
                  SideBarButton("Sym", 2),
                  SideBarButton("GE", 3),
                  SideBarButton("RS", 4),
                  SideBarButton("CVS", 5),
                  SideBarButton("CNS", 6),
                  SideBarButton("P/A", 7),
                ],
              ),
            ),
            SizedBox(
              width: 1,
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarButton extends StatefulWidget {
  String buttonText;
  int itemindex;

  SideBarButton(this.buttonText, this.itemindex);

  @override
  _SideBarButtonState createState() => _SideBarButtonState();
}

class _SideBarButtonState extends State<SideBarButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          widget.buttonText,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: Color(0xffededed),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                width: 1,
                color: Colors.grey.shade300,
                style: BorderStyle.solid)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Symptoms & Findings'),
                  ),
                ),
              ),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}

class topBar extends StatefulWidget {
  @override
  _topBarState createState() => _topBarState();
}

class _topBarState extends State<topBar> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: topBarVisibility,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  topBarVisibility = false;
                  sideBarVisibility = true;
                });
                controller2.forward();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.menu),
              ),
            ),
            Text(
              'Symptoms',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              'Findings',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100.0),
              child: Text(
                'All',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//https://api.myjson.com/bins/aiy6q
