import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car1/rideDetails.dart';
import 'package:car1/select_time.dart';
import 'package:car1/task.dart';
import 'package:flutter/material.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'list_profile.dart';
import 'task.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';

class userLocation extends StatefulWidget {
  @override
  _userLocationState createState() => _userLocationState();
}

class _userLocationState extends State<userLocation> {
  int _myTaskType;
  String taskVal;
  List<Task1> items2;
  FirestoreService1 fireServ = new FirestoreService1();
  StreamSubscription<QuerySnapshot> todoTasks1;

  @override
  void initState() {
    super.initState();

    items2 = new List();

    todoTasks1?.cancel();
    todoTasks1 = fireServ.getTaskList2().listen((QuerySnapshot snapshot) {
      final List<Task1> tasks = snapshot.documents
          .map((documentSnapshot) => Task1.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items2 = tasks;
      });
    });
  }

//String driverName;
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
  appState = StateWidget.of(context).state;
  appState = StateWidget.of(context).state;
  if (!appState.isLoading &&
      (appState.firebaseUserAuth == null ||
          appState.user == null ||
          appState.settings == null)) {
    return Text("Something went wrong!");
  } else {
    if (appState.isLoading) {
      _loadingVisible = true;
    } else {
      _loadingVisible = false;
    }


      var userLocation1 ;
      /*= appState?.user?.location ?? '';
      final fl=userLocation1;
*/

      //final Task1 items1 = ModalRoute.of(context).settings.arguments;
      final userIdLabel = Text('App Id: ');
      // final number = appState?.firebaseUserAuth?.uid ?? '';

      void _handleTask(int value) {
        setState(() {
          _myTaskType = value;

          switch (_myTaskType) {
            case 0:
              taskVal = '${items2[0].userLocation[0]}';
              break;
            case 1:
              taskVal = '${items2[0].userLocation[1]}';
              break;
            case 2:
              taskVal = '${items2[0].userLocation[2]}';
              break;
            case 3:
              taskVal = '${items2[0].userLocation[3]}';
              break;
            case 4:
              taskVal = '${items2[0].userLocation[4]}';
              break;
            /* case 5:
              taskVal = '${items2[1].userLocation[5]}';
              break;*/
            /*case 6:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 7:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 8:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 9:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 10:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 11:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 12:
              taskVal = '${items2[1].userLocation[0]}';
              break;*/
          }
        });
      }
      setState(() {
        userLocation1 = taskVal;
      });

      createData() {
//      final userId = appState?.firebaseUserAuth?.uid ?? '';
        //   final number1 = appState?.user?.number ?? '';

        DocumentReference ds =
            Firestore.instance.collection('3').document(userLocation1);

        Map<String, dynamic> data = {
          //"Size": selectedSizes,
          "userLocation": userLocation1,
        };
        /*ds.get().whenComplete(action){
        if(data)
      };*/
        ds.setData(data).whenComplete(() {
          print('Task created');
        });
      }

      createData2() {
//      final userId = appState?.firebaseUserAuth?.uid ?? '';
        //   final number1 = appState?.user?.number ?? '';

        DocumentReference ds =
            Firestore.instance.collection('3').document(userLocation1);

        Map<String, dynamic> data = {
          //"Size": selectedSizes,
          "ok2": userLocation1,
        };
        /*ds.get().whenComplete(action){
        if(data)
      };*/
        ds.updateData(data).whenComplete(() {
          print('Task created');
        });
      }

      return Scaffold(
        appBar: new AppBar(
          title: Text("Book your timimg :"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Available timings of :"),
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: 0,
                          groupValue: _myTaskType,
                          onChanged: _handleTask),
                      Text("${items2[0].userLocation[0]}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: 1,
                          groupValue: _myTaskType,
                          onChanged: _handleTask),
                      Text("${items2[0].userLocation[1]}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: 2,
                          groupValue: _myTaskType,
                          onChanged: _handleTask),
                      Text("${items2[0].userLocation[2]}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: 3,
                          groupValue: _myTaskType,
                          onChanged: _handleTask),
                      Text("${items2[0].userLocation[3]}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: 4,
                          groupValue: _myTaskType,
                          onChanged: _handleTask),
                      Text("${items2[0].userLocation[4]}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          /*setState(() {
                            userLocation1 = taskVal;
                          });*/
                          createData();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => listProfile(),
                                //settings: RouteSettings(),
                              ));
                        },
                        child: Text("Confirm 1"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {

                          createData2();

                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => rideDetails(),
                                //settings: RouteSettings(),
                              ));*/
                        },
                        child: Text("Confirm 2"),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
