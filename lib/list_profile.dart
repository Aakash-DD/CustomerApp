import 'package:car1/razorpay_flutter.dart';
import 'package:car1/reviews.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car1/yourBookings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/util/state_widget.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:car1/regestration/ui/screens/home.dart';

class listProfile extends StatefulWidget {
  @override
  _listProfileState createState() => _listProfileState();
}

class _listProfileState extends State<listProfile> {
  String _name0 = "";
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    //   final w_fl = appState?.user?.w_fl ?? '';

    Future getPosts() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("driver2")
          .document(_name0) //	Delhi Cantonment
          .collection("1")
          .getDocuments();
      return qn.documents;
    }

    navigateToDetail(DocumentSnapshot post1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DetailPage(post: post1)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Available drivers"),
      ),
      body: Container(
        child: FutureBuilder(
            future: getPosts(),
            builder: (_, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading ..."),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                     /* void saveName() {
                        savedNamePreferences("${snapshot.data[index].data["driverNumber"]}").then((_) {});
                      }*/
                      return Card(
                        child: ListTile(
                          onTap: () {
                            // page3(snapshot.data[index]);
                            navigateToDetail(snapshot.data[index]);
                          },
                          title: Column(
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(snapshot
                                            .data[index].data["driverImage"]))),
                              ),
//                                Image.network(snapshot.data[index].data["driverImage"]),
                              SizedBox(height: 10),
                              Text(
                                  "Name:  ${snapshot.data[index].data["driverName"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Gender:  ${snapshot.data[index].data["gender"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Experience:  ${snapshot.data[index].data["experience"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "From:  ${snapshot.data[index].data["dAddress"]}"),
                              SizedBox(
                                height: 10.0,
                              ),

                              RaisedButton(
                                onPressed: () {
                                  void saveName() {
                                    savedNamePreferences20("${snapshot.data[index].data["driverNumber"]}").then((_) {});
                                  }
                                  saveName();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => new reviews()));
                                },
                                child: Text("Reviews"),
                              ),

                              SizedBox(
                                height: 50.0,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }

  @override
  void initState() {
    getNamePreferences0().then(updateName0);
//    getNamePreferences20().then(updateName20);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateName0(String name0) {
    setState(() {
      this._name0 = name0;
    });
  }
  /*void updateName20(String name0) {
    setState(() {
      this._name0 = name0;
    });
  }
  */
//-------------------------------------------------------------------------

}
Future<bool> savedNamePreferences20(String name20) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name20", name20);	
  return prefs.commit();
}

Future<String> getNamePreferences20() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name20 = prefs.getString("name20");
  return name20;
}

//----------------------------------------------------Detail Page---------------------------------------------

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  //bool pressed = false;
  String taskname, tasksector, taskpocket, tasklandmark;
  int _myTaskType;
  String _name0 = "";
  String taskVal;
  DateTime _dateTime;
  StateModel appState;
  bool _loadingVisible = false;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        //borderRadius: BorderRadius.all(Radius.circular(2.0)),
        boxFit: BoxFit.fitHeight,
        images: [
          Image.network("${widget.post.data["driverImage"]}"),
          Image.network("${widget.post.data["carImage"]}")
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 6.0,
        dotBgColor: Colors.transparent,

        //showIndicator: true,
      ),
    );
    void _handleTask(int value) {
      setState(() {
        _myTaskType = value;

        switch (_myTaskType) {
          case 0:
            taskVal = '${widget.post.data["time"][0]}';
            break;
          case 1:
            taskVal = '${widget.post.data["time"][1]}';
            break;
          case 2:
            taskVal = '${widget.post.data["time"][2]}';
            break;
          case 3:
            taskVal = '${widget.post.data["time"][3]}';
            break;
          case 4:
            taskVal = '${widget.post.data["time"][4]}';
            break;
          case 5:
            taskVal = '${widget.post.data["time"][5]}';
            break;
          case 6:
            taskVal = '${widget.post.data["time"][6]}';
            break;
          case 7:
            taskVal = '${widget.post.data["time"][7]}';
            break;
          case 8:
            taskVal = '${widget.post.data["time"][8]}';
            break;
          case 9:
            taskVal = '${widget.post.data["time"][9]}';
            break;
          case 10:
            taskVal = '${widget.post.data["time"][10]}';
            break;
          case 11:
            taskVal = '${widget.post.data["time"][11]}';
            break;
          case 12:
            taskVal = '${widget.post.data["time"][12]}';
            break;
          case 13:
            taskVal = '${widget.post.data["time"][13]}';
            break;
          case 14:
            taskVal = '${widget.post.data["time"][14]}';
            break;
        }
      });
    }

    getTaskName(tasknameU) {
      this.taskname = tasknameU;
    }

    getTaskSector(tasksectorU) {
      this.tasksector = tasksectorU;
    }

    getTaskPocket(tasknameU) {
      this.taskpocket = tasknameU;
    }

    getTasklandmark(tasknameU) {
      this.tasklandmark = tasknameU;
    }

    appState = StateWidget.of(context).state;
    // final w_fl = appState?.user?.w_fl ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.post.data["driverName"]}:"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Text(
                          "Images...",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      image_carousel,
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Fill up the details below",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration:
                              InputDecoration(labelText: 'Enter your full address...'),
                          onChanged: (String name) {
                            getTaskName(name);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Sector'),
                          onChanged: (String name1) {
                            getTaskSector(name1);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Pocket'),
                          onChanged: (String name2) {
                            getTaskPocket(name2);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(labelText: 'landmark'),
                          onChanged: (String name3) {
                            getTasklandmark(name3);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Selected Date:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text("${selectedDate.toLocal()}".split(' ')[0]),
                            SizedBox(
                              height: 15.0,
                            ),
                            RaisedButton(
                              onPressed: () => _selectDate(context),
                              child: Text('Select date'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Select your time :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Ride for continous 8 days:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][0]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time0"] == "0") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 0,
                                              groupValue: _myTaskType,
                                              onChanged: _handleTask),
                                          Text(
                                              "${widget.post.data["time"][0]}"),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][1]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time1"] == "1") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 1,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][1]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][2]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time2"] == "2") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 2,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][2]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][3]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time3"] == "3") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 3,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][3]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][4]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time4"] == "4") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 4,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][4]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][5]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time5"] == "5") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 5,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][5]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][6]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time6"] == "6") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 6,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][6]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][7]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time7"] == "7") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 7,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][7]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][8]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time8"] == "8") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 8,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][8]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][9]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time9"] == "9") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 9,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][9]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][10]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time10"] == "10") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 10,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][10]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][11]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time11"] == "11") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 11,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][11]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][12]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time12"] == "12") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 12,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][12]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][13]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time13"] == "13") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 13,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][13]}"),
                                    ],
                                  );
                                }
                              })),
                      Container(
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('driver2')
                                  .document(_name0)
                                  .collection("1")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if ({widget.post.data["time"][14]}
                                    .contains('N/A')) {
                                  return new Row(
                                    children: <Widget>[
                                      //Text("Driver not available")
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                } else if (widget.post.data["time14"] == "14") {
                                  return SizedBox(
                                    height: 0,
                                  );
                                } else {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 14,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${widget.post.data["time"][14]}"),
                                    ],
                                  );
                                }
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () {
                              // updatearray();
                              check();
                            },
                            child: Text(
                              "Proceed to Checkout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveName() {
    savedNamePreferences(taskVal).then((_) {});
    savedNamePreferences2(taskname).then((_) {});

    savedNamePreferences3(tasksector).then((_) {});
    savedNamePreferences4(taskpocket).then((_) {});
    savedNamePreferences5(tasklandmark).then((_) {});
    savedNamePreferences6(widget.post.data["carImage"]).then((_) {});
    savedNamePreferences7(widget.post.data["driverImage"]).then((_) {});
    savedNamePreferences8(widget.post.data["driverName"]).then((_) {});
    savedNamePreferences9(widget.post.data["gender"]).then((_) {});
    savedNamePreferences10(widget.post.data["driverNumber"]).then((_) {});
    savedNamePreferences11(widget.post.data["experience"]).then((_) {});
    savedNamePreferences12("${selectedDate.toLocal()}".split(' ')[0])
        .then((_) {});
    //savedNamePreferences13(widget.post.data["driverNumber"]).then((_) {});
    savedNamePreferences13("$_myTaskType").then((_) {});
  }

  Future check() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (taskVal != null &&
          taskname != null &&
          tasksector != null &&
          taskpocket != null &&
          tasklandmark != null &&
          selectedDate != null && widget.post.data["gender"]=="Male") {
        // _formKey.currentState.reset();
        setState(() => isLoading = false);
        saveName();
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
      }
      else if (taskVal != null &&
          taskname != null &&
          tasksector != null &&
          taskpocket != null &&
          tasklandmark != null &&
          selectedDate != null && widget.post.data["gender"]=="Female") {
        // _formKey.currentState.reset();
        setState(() => isLoading = false);
        saveName();
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp2()));
      }
      else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Fill all the details...');
      }
    }
  }


  /*Future check2() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (taskVal != null &&
          taskname != null &&
          tasksector != null &&
          taskpocket != null &&
          tasklandmark != null &&
          selectedDate != null && widget.post.data["gender"]=="Female") {
        // _formKey.currentState.reset();
        setState(() => isLoading = false);
        saveName();
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Fill all the details...');
      }
    }
  }*/

  @override
  void initState() {
    getNamePreferences0().then(updateName0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateName0(String name0) {
    setState(() {
      this._name0 = name0;
    });
  }
}

//-------------------------------------------------------------------------------------------------------------------------
Future<bool> savedNamePreferences(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences2(String name2) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name2", name2);
  return prefs.commit();
}

Future<bool> savedNamePreferences3(String name3) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name3", name3);
  return prefs.commit();
}

Future<bool> savedNamePreferences4(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name4", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences5(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name5", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences6(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name6", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences7(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name7", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences8(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name8", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences9(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name9", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences10(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString("name10", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences11(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name11", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences12(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name12", name);
  return prefs.commit();
}

Future<bool> savedNamePreferences13(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name13", name);
  return prefs.commit();
}

// -------------------------------------------------------------------------------------------------------------------------
Future<String> getNamePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}

Future<String> getNamePreferences2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name2 = prefs.getString("name2");
  return name2;
}

Future<String> getNamePreferences3() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name3 = prefs.getString("name3");
  return name3;
}

Future<String> getNamePreferences4() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name4");
  return name;
}

Future<String> getNamePreferences5() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name5");
  return name;
}

Future<String> getNamePreferences6() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name6");
  return name;
}

Future<String> getNamePreferences7() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name7");
  return name;
}

Future<String> getNamePreferences8() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name8");
  return name;
}

Future<String> getNamePreferences9() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name9");
  return name;
}

Future<String> getNamePreferences10() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name10");
  return name;
}

Future<String> getNamePreferences11() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name11");
  return name;
}

Future<String> getNamePreferences12() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name12");
  return name;
}

Future<String> getNamePreferences13() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name13");
  return name;
}

//------------------------------------------------------------------------------------------new Class-----------------------

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StateModel appState;
  bool _loadingVisible = false;
  String _name0 = "";
  String _name = ""; //taskVal -> time
  String _name2 = ""; //taskname---> address
  String _name3 = ""; //tasksector
  String _name4 = ""; //taskpocket
  String _name5 = ""; //tasklandmark
  String _name6 = ""; //widget.post.data["carImage"]
  String _name7 = ""; //["driverImage"]
  String _name8 = ""; //["driverName"]
  String _name9 = ""; //["gender"]
  String _name10 = ""; //["driverNumber"]
  String _name11 = ""; //["experience"]
  String _name12 = ""; //["date"
  String _name13 = ""; //_mytasktype
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                "Details :",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Driver name: $_name8",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Gender: $_name9",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Time: $_name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Scheduled on : $_name12",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: openCheckout,
                  child: Text(
                    'Proceed to Pay',
                    style: TextStyle(color: Colors.white),
                  )),
                  SizedBox(height: 40,),
            ])),
      ),
    );
  }

  @override
  void initState() {
    getNamePreferences0().then(updateName0);
    getNamePreferences().then(updateName);

    getNamePreferences2().then(updateName2);

    getNamePreferences3().then(updateName3);
    getNamePreferences4().then(updateName4);
    getNamePreferences5().then(updateName5);
    getNamePreferences6().then(updateName6);
    getNamePreferences7().then(updateName7);
    getNamePreferences8().then(updateName8);
    getNamePreferences9().then(updateName9);
    getNamePreferences10().then(updateName10);
    getNamePreferences11().then(updateName11);
    getNamePreferences12().then(updateName12);
    getNamePreferences13().then(updateName13);
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    appState = StateWidget.of(context).state;
    final firstName = appState?.user?.firstName ?? '';

    var options = {
      //uk0oxejvoVFCX7ugSxA1Krfg //rzp_live_vJ1fVNuySnZ6nZ
      'key': 'rzp_live_vJ1fVNuySnZ6nZ',
      //'rzp_test_1DP5mmOlF5G5ag',
      'amount': 2999 * 100,
      'name': 'deepbrothers',
      'image':
          "https://firebasestorage.googleapis.com/v0/b/signin-66177.appspot.com"
              "/o/logodb2%20(7).png?alt=media&token=9fb95b70-0669-4769-8dc2-3c452316624c",
      //'https://www.73lines.com/web/image/12427',
      'description': "payed by $firstName",
      'prefill': {'contact': '', 'email': ''},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('EEE d MMM y - kk:mm:ss').format(now);

    confirm() {
      // for driver

      appState = StateWidget.of(context).state;
      final firstName = appState?.user?.firstName ?? '';
      final number = appState?.user?.number ?? '';
      DocumentReference ds = Firestore.instance
          .collection("customer2")
          .document(_name10) //{widget.post.data["driverNumber"]}
          .collection("1")
          .document(number + " - $formattedDate");

      Map<String, dynamic> data = {
        //"Status": firstName + " $lastName",
        "customerName": firstName,
        "customerNumber": number,
        "time": _name,
        "status": "Waiting...",
        "address": _name2, //taskname
        "sector": _name3, //tasksector,
        "pocket": _name4, //taskpocket,
        "landmark": _name5, //tasklandmark,
        "rideOn": _name12,
        "createdOn": number + " - $formattedDate",
        "payment": "Done !"
      };
      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }

    confirm2() {
      // to fetched only on customer side i.e yourBookings
      appState = StateWidget.of(context).state;
      //final userId = appState?.firebaseUserAuth?.uid ?? '';
      final number = appState?.user?.number ?? '';

      DocumentReference ds = Firestore.instance
          .collection(
              "confirmed_c_rides2") //to be fetched to customer in yourBookings.dart
          .document(number)
          .collection('1')
          .document(number + " - $formattedDate");

      Map<String, dynamic> data = {
        //"Status": firstName + " $lastName",
        "carImage": _name6,
        "driverImage": _name7,
        "experience": _name11,
        "driverName": _name8,
        "gender": _name9,
        "time": _name,
        "driverNumber": _name10,
        "status": "Waiting...",
        "rideOn": _name12,
        "payment": "Done !"
      };
      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }

    updatearray() {
      // to fetched only on customer side i.e yourBookings
      appState = StateWidget.of(context).state;
      //final userId = appState?.firebaseUserAuth?.uid ?? '';
      final number = appState?.user?.number ?? '';

      Firestore.instance
          .collection('driver2')
          .document(_name0)
          .collection('1')
          .document(_name10)
          .updateData({
        'time$_name13': "$_name13",
        //time1 field of deleted from user's side to change driver's timings so not shown on others people timings
      }).whenComplete(() {
        print('Field Deleted');
      });
    }

    updatearray();
    confirm();
    confirm2();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => yourBookings(),
      ),
      (Route<dynamic> route) => false,
    );
    Fluttertoast.showToast(msg: "Successfully", timeInSecForIos: 4);
    Fluttertoast.showToast(
        msg: "Status: Waiting...waiting for driver to confirm",
        timeInSecForIos: 8);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  void updateName0(String name0) {
    setState(() {
      this._name0 = name0;
    });
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void updateName2(String name2) {
    setState(() {
      this._name2 = name2;
    });
  }

  void updateName3(String name3) {
    setState(() {
      this._name3 = name3;
    });
  }

  void updateName4(String name) {
    setState(() {
      this._name4 = name;
    });
  }

  void updateName5(String name) {
    setState(() {
      this._name5 = name;
    });
  }

  void updateName6(String name) {
    setState(() {
      this._name6 = name;
    });
  }

  void updateName7(String name) {
    setState(() {
      this._name7 = name;
    });
  }

  void updateName8(String name) {
    setState(() {
      this._name8 = name;
    });
  }

  void updateName9(String name) {
    setState(() {
      this._name9 = name;
    });
  }

  void updateName10(String name) {
    setState(() {
      this._name10 = name;
    });
  }

  void updateName11(String name) {
    setState(() {
      this._name11 = name;
    });
  }

  void updateName12(String name) {
    setState(() {
      this._name12 = name;
    });
  }

  void updateName13(String name) {
    setState(() {
      this._name13 = name;
    });
  }
}

//-------------------------------------MyApp 2 ----------------------------------------------------------------------------


class MyApp2 extends StatefulWidget {
  @override
  _MyAppState2 createState() => _MyAppState2();
}

class _MyAppState2 extends State<MyApp2> {
  StateModel appState;
  bool _loadingVisible = false;
  String _name0 = "";
  String _name = ""; //taskVal -> time
  String _name2 = ""; //taskname---> address
  String _name3 = ""; //tasksector
  String _name4 = ""; //taskpocket
  String _name5 = ""; //tasklandmark
  String _name6 = ""; //widget.post.data["carImage"]
  String _name7 = ""; //["driverImage"]
  String _name8 = ""; //["driverName"]
  String _name9 = ""; //["gender"]
  String _name10 = ""; //["driverNumber"]
  String _name11 = ""; //["experience"]
  String _name12 = ""; //["date"
  String _name13 = ""; //_mytasktype
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Details :",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Driver name: $_name8",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Gender: $_name9",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Time: $_name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Scheduled on : $_name12",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: openCheckout,
                      child: Text(
                        'Proceed to Pay',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(height: 40,),
                ])),
      ),
    );
  }

  @override
  void initState() {
    getNamePreferences0().then(updateName0);
    getNamePreferences().then(updateName);

    getNamePreferences2().then(updateName2);

    getNamePreferences3().then(updateName3);
    getNamePreferences4().then(updateName4);
    getNamePreferences5().then(updateName5);
    getNamePreferences6().then(updateName6);
    getNamePreferences7().then(updateName7);
    getNamePreferences8().then(updateName8);
    getNamePreferences9().then(updateName9);
    getNamePreferences10().then(updateName10);
    getNamePreferences11().then(updateName11);
    getNamePreferences12().then(updateName12);
    getNamePreferences13().then(updateName13);
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    appState = StateWidget.of(context).state;
    final firstName = appState?.user?.firstName ?? '';

    var options = {
      //uk0oxejvoVFCX7ugSxA1Krfg //rzp_live_vJ1fVNuySnZ6nZ
      'key': 'rzp_live_vJ1fVNuySnZ6nZ',
      //'rzp_test_1DP5mmOlF5G5ag',
      'amount': 3999 * 100,
      'name': 'deepbrothers',
      'image':
      "https://firebasestorage.googleapis.com/v0/b/signin-66177.appspot.com"
          "/o/logodb2%20(7).png?alt=media&token=9fb95b70-0669-4769-8dc2-3c452316624c",
      //'https://www.73lines.com/web/image/12427',
      'description': "payed by $firstName",
      'prefill': {'contact': '', 'email': ''},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('EEE d MMM y - kk:mm:ss').format(now);

    confirm() {
      // for driver

      appState = StateWidget.of(context).state;
      final firstName = appState?.user?.firstName ?? '';
      final number = appState?.user?.number ?? '';
      DocumentReference ds = Firestore.instance
          .collection("customer2")
          .document(_name10) //{widget.post.data["driverNumber"]}
          .collection("1")
          .document(number + " - $formattedDate");

      Map<String, dynamic> data = {
        //"Status": firstName + " $lastName",
        "customerName": firstName,
        "customerNumber": number,
        "time": _name,
        "status": "Waiting...",
        "address": _name2, //taskname
        "sector": _name3, //tasksector,
        "pocket": _name4, //taskpocket,
        "landmark": _name5, //tasklandmark,
        "rideOn": _name12,
        "createdOn": number + " - $formattedDate",
        "payment": "Done !"
      };
      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }

    confirm2() {
      // to fetched only on customer side i.e yourBookings
      appState = StateWidget.of(context).state;
      //final userId = appState?.firebaseUserAuth?.uid ?? '';
      final number = appState?.user?.number ?? '';

      DocumentReference ds = Firestore.instance
          .collection(
          "confirmed_c_rides2") //to be fetched to customer in yourBookings.dart
          .document(number)
          .collection('1')
          .document(number + " - $formattedDate");

      Map<String, dynamic> data = {
        //"Status": firstName + " $lastName",
        "carImage": _name6,
        "driverImage": _name7,
        "experience": _name11,
        "driverName": _name8,
        "gender": _name9,
        "time": _name,
        "driverNumber": _name10,
        "status": "Waiting...",
        "rideOn": _name12,
        "payment": "Done !"
      };
      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }

    updatearray() {
      // to fetched only on customer side i.e yourBookings
      appState = StateWidget.of(context).state;
      //final userId = appState?.firebaseUserAuth?.uid ?? '';
      final number = appState?.user?.number ?? '';

      Firestore.instance
          .collection('driver2')
          .document(_name0)
          .collection('1')
          .document(_name10)
          .updateData({
        'time$_name13': "$_name13",
        //time1 field of deleted from user's side to change driver's timings so not shown on others people timings
      }).whenComplete(() {
        print('Field Deleted');
      });
    }

    updatearray();
    confirm();
    confirm2();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => yourBookings(),
      ),
          (Route<dynamic> route) => false,
    );
    Fluttertoast.showToast(msg: "Successfully", timeInSecForIos: 4);
    Fluttertoast.showToast(
        msg: "Status: Waiting...waiting for driver to confirm",
        timeInSecForIos: 8);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  void updateName0(String name0) {
    setState(() {
      this._name0 = name0;
    });
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void updateName2(String name2) {
    setState(() {
      this._name2 = name2;
    });
  }

  void updateName3(String name3) {
    setState(() {
      this._name3 = name3;
    });
  }

  void updateName4(String name) {
    setState(() {
      this._name4 = name;
    });
  }

  void updateName5(String name) {
    setState(() {
      this._name5 = name;
    });
  }

  void updateName6(String name) {
    setState(() {
      this._name6 = name;
    });
  }

  void updateName7(String name) {
    setState(() {
      this._name7 = name;
    });
  }

  void updateName8(String name) {
    setState(() {
      this._name8 = name;
    });
  }

  void updateName9(String name) {
    setState(() {
      this._name9 = name;
    });
  }

  void updateName10(String name) {
    setState(() {
      this._name10 = name;
    });
  }

  void updateName11(String name) {
    setState(() {
      this._name11 = name;
    });
  }

  void updateName12(String name) {
    setState(() {
      this._name12 = name;
    });
  }

  void updateName13(String name) {
    setState(() {
      this._name13 = name;
    });
  }
}
