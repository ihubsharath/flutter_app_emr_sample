import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Model2.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

AnimationController controller;
Animation<Offset> offset;
var navigator;
Model2 emrDataList;
Future<Model2> fetchEMRdata;
var namesList = List<String>();
void main() => runApp(MyApp());
bool _saving = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    return ModalProgressHUD(
      child: SafeArea(
        child: FutureBuilder<Model2>(
          future: fetchEMRdata,
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(widget.title),
              ),
              drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        child: Image.asset(
                          "images/kkreddylogo.png",
                          height: 120,
                          width: 120,
                        ),
                        radius: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "EMR R and D",
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            navigator = symptomsWidget(snapshot.data.result);
                            Navigator.pop(context);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20, bottom: 20),
                          child: Text(
                            "Symptoms",
                            style: TextStyle(
                              color: Color(0xff555555),
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            navigator = deseasesWidget(snapshot.data.result);
                            Navigator.pop(context);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20, bottom: 20),
                          child: Text(
                            'Deseases',
                            style: TextStyle(
                              color: Color(0xff555555),
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 30.0),
                            leading: Image.asset(
                              'images/logout.png',
                              height: 50,
                              width: 50,
                              color: Color(0xff83AE45),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: Color(0xff83AE45),
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Center(
                //child: navigator,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.clear),
                          Text('All'),
                          Text('Sym'),
                          Text('RE'),
                          Text('CVR'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: navigator,
                    )
                    //navigator
                  ],
                ),

                //navigator,
                //child: deseasesWidget(snapshot.data.result),
              ),
            );
          },
        ),
      ),
      inAsyncCall: _saving,
    );
  }

  Future<Model2> getEMRdata() async {
//    Response response = await get("https://api.myjson.com/bins/1bif22");
    Response response =
        await get("http://qurix.ai:8080/qurix_uat/openapi/orginfo/"
            "getlocations?seuuid=b31e2a35-eab4-47c3-9493-327d47673ebc");
    emrDataList = Model2.fromJson(jsonDecode(response.body));
    print("emrdata" + emrDataList.toString());
    setState(() {
      _saving = true;
      navigator = symptomsWidget(emrDataList.result);
    });

//    for (var comment in emrDataList.result) {
//      nameWidgets.add(
//        Container(
//          margin: EdgeInsets.all(10),
//          height: 50,
//          width: 100,
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.all(Radius.circular(10)),
//              border: Border.all(
//                  width: 1, color: Colors.green, style: BorderStyle.solid)),
//          child: Center(
//              child: Text(
//            comment.name,
//            style: TextStyle(fontSize: 10),
//          )),
//        ),
//      ); // TODO: Whatever layout you need for each widget.
//    }
    return emrDataList;
  }
}

class deseasesWidget extends StatefulWidget {
  List<Result> result;
  deseasesWidget(this.result);

  @override
  _deseasesWidgetState createState() => _deseasesWidgetState();
}

class _deseasesWidgetState extends State<deseasesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                color: Colors.greenAccent.shade100,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid)),
                        child: Center(
                            child: Text(widget.result[index].id.toString())),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey,
            child: Column(
              children: <Widget>[],
            ),
          ),
        )
      ],
    );
  }
}

class symptomsWidget extends StatefulWidget {
  List<Result> result;
  symptomsWidget(this.result);

  @override
  _symptomsWidgetState createState() => _symptomsWidgetState();
}

class _symptomsWidgetState extends State<symptomsWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));

    offset = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller);
    //controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: namesList.length == 0 ? 0 : 150,
                    child: GridView.builder(
                        itemCount: namesList.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 4 / 2, crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  namesList.removeAt(index);
                                  controller.reverse();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  //width: 150,
                                  decoration: BoxDecoration(
                                      color: Color(0xffC90144),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.green,
                                          style: BorderStyle.solid)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          namesList[index],
                                          style: TextStyle(fontSize: 10),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Icon(Icons.cancel),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: widget.result.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 2, crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              namesList.add(widget.result[index].name);
//                              controller.isAnimating == true
//                                  ? controller.repeat(
//                                      min: 1.0,
//                                      max: 1.0,
//                                      period: Duration(milliseconds: 300),
//                                      reverse: true)
                              //    :
                              controller.forward();
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffFFF2F7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xffC90144),
                                    style: BorderStyle.solid)),
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                widget.result[index].name,
                                style: TextStyle(fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SlideTransition(
            position: offset,
            child: Container(
              color: Colors.grey,
              child: Column(
                children: <Widget>[],
              ),
            ),
          ),
        )
      ],
    );
  }
}
//https://api.myjson.com/bins/aiy6q
