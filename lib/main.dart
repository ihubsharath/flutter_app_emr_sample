import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/Model.dart';
import 'package:flutter_app/widgets/Sidebar.dart';
import 'package:http/http.dart';

import 'SymptomsScreen2.dart';

int selectedPage;
var pageOptions;

Model emrDataList;
Future<Model> fetchEMRdata;

var symptomsList = List();
var diagnosisList = List();

void main() => runApp(MyApp());
bool _saving = false;
var topBarVisibility = true;
var sideBarVisibility = false;

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
            body: pageOptions[selectedPage],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedPage,
              onTap: (int index) {
                setState(() {
                  selectedPage = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital),
                  title: Text('Hospital'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.airplanemode_active),
                  title: Text('Airport'),
                ),
              ],
            ),
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
        diagnosisList.add(item.name);
      }
      navigator = symptomsWidget(symptomsList, diagnosisList);
      selectedPage = 0;
      pageOptions = [
        navigator,
        ScreenTwo(),
        ScreenThree(),
      ];
    });
    return emrDataList;
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
      position: topSideOffset,
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
                      topSideController.reverse();
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
                topSideController.forward();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.menu),
              ),
            ),
            Text(
              'Symptoms',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Findings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100.0),
              child: Text(
                'All',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//https://api.myjson.com/bins/aiy6q
