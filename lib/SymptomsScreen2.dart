import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppRelatedData.dart';
import 'package:flutter_app/models/Model.dart';
import 'package:flutter_app/widgets/Searchbox.dart';
import 'package:flutter_app/widgets/Sidebar.dart';

AnimationController rightSideController, topSideController, leftSideController;
Animation<Offset> rightSideOffset, topSideOffset, leftSideOffset;
var navigator;

int selectedPage;
var pageOptions;

Model emrDataList;
Future<Model> fetchEMRdata;
final Map<String, int> someMap = {};
var namesList = List();
final Map<String, int> someMap2 = {};
var namesList2 = List();
var symptomsList = List();
var symptomsList2 = List();
var topBarVisibility = true;
var sideBarVisibility = false;
AppRelatedData appRelatedData = AppRelatedData();
String selectedReason = appRelatedData.durationType[0].type;
String selectedReasonId = appRelatedData.durationType[0].typeId;

class symptomsWidget extends StatefulWidget {
  List symptoms, diagnosisList;

  symptomsWidget(this.symptoms, this.diagnosisList);

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
  bool diagnosisVisibility = false;
  bool symptomsVisibility = false;

  @override
  void initState() {
    super.initState();

    rightSideController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ));

    leftSideController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ));

    topSideController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 150,
        ));
    rightSideOffset =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(rightSideController);
    leftSideOffset =
        Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(leftSideController);

    topSideOffset =
        Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(topSideController);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //SideBar(),
                  SlideTransition(
                    position: topSideOffset,
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
                                      topSideController.reverse();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
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
                                    topSideController.forward();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(Icons.menu),
                                  ),
                                ),
                                Text(
                                  'Symptoms',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'Findings',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 100.0),
                                  child: Text(
                                    'All',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SearchBox("Search Symptoms & Findings"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: Wrap(
                                          spacing: 20,
                                          runSpacing: 20,
                                          children: List<Widget>.generate(
                                              namesList.length, (int index) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  top: 12.0,
                                                  bottom: 12.0),
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffC90144),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.white,
                                                      style:
                                                          BorderStyle.solid)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedSymptom =
                                                            namesList[index];
                                                        symptomsVisibility =
                                                            true;
                                                        rightSideController
                                                            .forward();
                                                      });
                                                    },
                                                    child: Text(
                                                      namesList[index],
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        for (var entry
                                                            in someMap
                                                                .entries) {
                                                          if (entry.key ==
                                                              namesList[
                                                                  index]) {
                                                            if (entry.value <=
                                                                widget.symptoms
                                                                    .length) {
                                                              actualIndex =
                                                                  entry.value;
                                                            } else {
                                                              actualIndex =
                                                                  widget
                                                                      .symptoms
                                                                      .length;
                                                            }
                                                          }
                                                        }
                                                        symptomsVisibility =
                                                            false;
                                                        widget.symptoms.insert(
                                                            actualIndex,
                                                            namesList[index]);
                                                        namesList
                                                            .removeAt(index);
                                                        rightSideController
                                                            .reverse();
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 10.0),
                                                      child: Icon(
                                                        Icons.cancel,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      namesList.length == 0
                                          ? Container()
                                          : Divider(
                                              height: 30,
                                              color: Colors.grey,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MainWidget(widget.symptoms,
                                      symptomsVisibility, selectedSymptom),
                                  Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SlideTransition(
                position: leftSideOffset,
                child: Visibility(
                  visible: diagnosisVisibility,
                  child: Row(
                    children: <Widget>[
                      Expanded(
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
                                              "Selected Diagnosis: " +
                                                  selectedSymptom,
                                              style: TextStyle(fontSize: 18),
                                            )),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        leftSideController.reverse();
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Text("Note"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
//                                      border: Border.all(
////                                          width: 1,
//                                          color: Colors.grey.shade300,
//                                          style: BorderStyle.solid)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: Text(
                                  'Location',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
//                                      border: Border.all(
////                                          width: 1,
//                                          color: Colors.grey.shade300,
//                                          style: BorderStyle.solid)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: Text(
                                  'Description',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
//                                      border: Border.all(
////                                          width: 1,
//                                          color: Colors.grey.shade300,
//                                          style: BorderStyle.solid)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      '+ Add History Query',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 1,
            child: Container(
              color: Colors.grey.shade500,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //SideBar(),
                  //sideNavigator,
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 10,
                                        bottom: 15),
                                    child: Text(
                                      "Diagnosis",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SearchBox("Search Diagnosis"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: namesList2.length == 0
                                        ? 0
                                        : (namesList2.length <= 4
                                            ? 100
                                            : namesList2.length / 4 * 100),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              itemCount: namesList2.length,
                                              gridDelegate:
                                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 4 / 2,
                                                      crossAxisCount: 4),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Center(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            top: 15,
                                                            bottom: 15,
                                                            right: 10),
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Colors.white,
                                                            style: BorderStyle
                                                                .solid)),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedSymptom =
                                                                  namesList2[
                                                                      index];
                                                              diagnosisVisibility =
                                                                  true;
                                                              leftSideController
                                                                  .forward();
                                                            });
                                                          },
                                                          child: Text(
                                                            namesList2[index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              for (var entry
                                                                  in someMap2
                                                                      .entries) {
                                                                if (entry.key ==
                                                                    namesList2[
                                                                        index]) {
                                                                  if (entry
                                                                          .value <=
                                                                      widget
                                                                          .diagnosisList
                                                                          .length) {
                                                                    actualIndex =
                                                                        entry
                                                                            .value;
                                                                  } else {
                                                                    actualIndex = widget
                                                                        .diagnosisList
                                                                        .length;
                                                                  }
                                                                }
                                                              }
                                                              diagnosisVisibility =
                                                                  false;
                                                              widget
                                                                  .diagnosisList
                                                                  .insert(
                                                                      actualIndex,
                                                                      namesList2[
                                                                          index]);
                                                              namesList2
                                                                  .removeAt(
                                                                      index);
                                                              leftSideController
                                                                  .reverse();
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Icon(
                                                              Icons.cancel,
                                                              size: 17,
                                                              color:
                                                                  Colors.white,
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
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
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
                                    itemCount: widget.diagnosisList.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 4 / 2,
                                            crossAxisCount: 4),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              diagnosisVisibility = true;
                                              someMap2[widget
                                                      .diagnosisList[index]] =
                                                  index;
                                              namesList2.add(
                                                  widget.diagnosisList[index]);
                                              selectedSymptom =
                                                  widget.diagnosisList[index];
                                              leftSideController.forward();
                                              widget.diagnosisList
                                                  .removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                            ),
                                            decoration: BoxDecoration(
//                                              color: Color(0xffFFF2F7),
                                              border: Border.all(
                                                color: Colors.grey.shade400,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                            ),
                                            child: Text(
                                                widget.diagnosisList[index],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                ],
              ),
              SlideTransition(
                position: rightSideOffset,
                child: Visibility(
                  visible: symptomsVisibility,
                  child: Container(
                    color: Colors.white,
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
                                  rightSideController.reverse();
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                    style: BorderStyle.solid)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
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
                                        margin: EdgeInsets.only(
                                            left: 10, right: 20),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainWidget extends StatefulWidget {
  List symptoms;
  bool symptomsVisibility;
  String selectedSymptom;
  MainWidget(this.symptoms, this.symptomsVisibility, this.selectedSymptom);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List<Widget>.generate(widget.symptoms.length, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.symptomsVisibility = true;
                someMap[widget.symptoms[index]] = index;
                namesList.add(widget.symptoms[index]);
                widget.selectedSymptom = widget.symptoms[index];
                rightSideController.forward();
                widget.symptoms.removeAt(index);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
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
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          );
        }),
      ),
    );
  }
}

class ScreenThree extends StatelessWidget {
  const ScreenThree({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red.shade50, child: Center(child: Text('Screen Three')));
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green.shade50, child: Center(child: Text('Screen Two')));
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
