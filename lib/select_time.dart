/*
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'task.dart';
import 'dart:async';


class selectTime extends StatefulWidget {
  @override
  _selectTimeState createState() => _selectTimeState();
}

class _selectTimeState extends State<selectTime> {
  int _myTaskType = 0;
  String taskVal;
  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    super.initState();

    items = new List();

    todoTasks?.cancel();
    todoTasks = fireServ.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Task> tasks = snapshot.documents
          .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Timings...'),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            void _handleTask(int value) {
              setState(() {
                _myTaskType = value;

                switch (_myTaskType) {
                  case 0:
                    taskVal = '${items[index].time[0]}';
                    break;
                  case 1:
                    taskVal = '${items[index].time[1]}';
                    break;
                  case 2:
                    taskVal = '${items[index].time[2]}';
                    break;
                  case 3:
                    taskVal = '${items[index].time[3]}';
                    break;
                  case 4:
                    taskVal = '${items[index].time[4]}';
                    break;
                  case 5:
                    taskVal = '${items[index].time[5]}';
                    break;
                  case 6:
                    taskVal = '${items[index].time[6]}';
                    break;
                  case 7:
                    taskVal = '${items[index].time[7]}';
                    break;
                  case 8:
                    taskVal = '${items[index].time[8]}';
                    break;
                  case 9:
                    taskVal = '${items[index].time[9]}';
                    break;
                  case 10:
                    taskVal = '${items[index].time[10]}';
                    break;
                  case 11:
                    taskVal = '${items[index].time[11]}';
                    break;
                  case 12:
                    taskVal = '${items[index].time[12]}';
                    break;
                }
              });
            }

            return SingleChildScrollView(
              child: Column(children: <Widget>[
                // The containers in the background
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //height: 80.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          shadowColor: Color(0x802196F3),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[0]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  ),
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 0,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[0]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[1]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  ),
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 1,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[1]}"),
                                                ],
                                              );
                                            }      })),

                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[2]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 2,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[2]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[3]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 3,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[3]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[4]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 4,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[4]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[5]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 5,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[5]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[6]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 6,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[6]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[7]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 7,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[7]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[8]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 8,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[8]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[9]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 9,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[9]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[10]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 10,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[10]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[11]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              //<DocumentSnapshot> ds= snapshot.data.documents;
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 11,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[11]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].time[12]}.contains('na')){
                                              return new Row(
                                                children: <Widget>[
                                                  //Text("Driver not available")
                                                  SizedBox(
                                                    height: 0,
                                                  )
                                                ],
                                              );

                                            } else {
                                              return  Row(
                                                children: <Widget>[

                                                  Radio(
                                                      value: 12,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].time[12]}"),
                                                ],
                                              );
                                            }      })),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 21,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("4 pm "),
                                    ],
                                  ),
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        RaisedButton(
                                          color: Colors.black,
                                          onPressed: () {
                                            //createData();
                                          },
                                          child: Text(
                                            "Confirm",
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ]),
            );
          }),
    );
  }
}
*/
