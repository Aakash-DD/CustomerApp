/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'task.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _myTaskType = 0;
  String taskVal;
  String taskname;

  //List<String> selectedBox = <String>[];
  List<String> selectedSizes = <String>[];
  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

void _handleTask(int value) {
    setState(() {
      _myTaskType = value;

      switch (_myTaskType) {
        case 1:
          taskVal = value as String;
          break;


case 2:
          taskVal = Firestore.instance.collection('dri_work_time') as String;
          break;
        case 3:
          taskVal = Firestore.instance.collection('dri_work_time') as String;
          break;
        case 4:
          taskVal = Firestore.instance.collection('dri_work_time') as String;
          break;
      }
    });
  }


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

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('car_cust-1').document('lol1');
    Map<String, dynamic> tasks = {
      //"Size": selectedSizes,
      "Time": taskname,
      "2": taskVal,
    };
    ds.setData(tasks).whenComplete(() {
      print('Task created');
    });
  }

  @override
  Widget build(BuildContext context) {
    getTaskName(tasknameU) {
      this.taskname = tasknameU;
    }

    return Scaffold(
      appBar: new AppBar(),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            void _handleTask(int value) {
              setState(() {
                _myTaskType = value;

                switch (_myTaskType) {
                  case 0:
                    taskVal = '${items[index].SunToMon[0]}';
                    break;
                  case 1:
                    taskVal = '${items[index].SunToMon[1]}';
                    break;
                  case 2:
                    taskVal = '${items[index].SunToMon[2]}';
                    break;
                  case 3:
                    taskVal = '${items[index].SunToMon[3]}';
                    break;
                  case 4:
                    taskVal = '${items[index].SunToMon[4]}';
                    break;
                  case 5:
                    taskVal = '${items[index].SunToMon[5]}';
                    break;
                  case 6:
                    taskVal = '${items[index].SunToMon[6]}';
                    break;
                  case 7:
                    taskVal = '${items[index].SunToMon[7]}';
                    break;
                  case 8:
                    taskVal = '${items[index].SunToMon[8]}';
                    break;
                  case 9:
                    taskVal = '${items[index].SunToMon[9]}';
                    break;
                  case 10:
                    taskVal = '${items[index].SunToMon[10]}';
                    break;
                  case 11:
                    taskVal = '${items[index].SunToMon[11]}';
                    break;
                  case 12:
                    taskVal = '${items[index].SunToMon[12]}';
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
                                            if({items[index].SunToMon[0]}.contains('na')){
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
                                                      "${items[index].SunToMon[0]}"),
                                                ],
                                              );
                                            }      })),
                                Container(

                                     child:  new StreamBuilder(
                                        stream: Firestore.instance.collection('dri_work_time').
                                        limit(10).snapshots(),
                                        builder: (context, snapshot) {
                                      if({items[index].SunToMon[1]}.contains('na')){
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
                                            "${items[index].SunToMon[1]}"),
                                      ],
                                    );
                                  }      })),

                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[2]}.contains('na')){
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
                                                      "${items[index].SunToMon[2]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[3]}.contains('na')){
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
                                                      "${items[index].SunToMon[3]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[4]}.contains('na')){
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
                                                      "${items[index].SunToMon[4]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[5]}.contains('na')){
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
                                                      "${items[index].SunToMon[5]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[6]}.contains('na')){
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
                                                      "${items[index].SunToMon[6]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[7]}.contains('na')){
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
                                                      "${items[index].SunToMon[7]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[8]}.contains('na')){
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
                                                      "${items[index].SunToMon[8]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[9]}.contains('na')){
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
                                                      "${items[index].SunToMon[9]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[10]}.contains('na')){
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
                                                      "${items[index].SunToMon[10]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[11]}.contains('na')){
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
                                                      "${items[index].SunToMon[11]}"),
                                                ],
                                              );
                                            }      })),
                                  Container(

                                      child:  new StreamBuilder(
                                          stream: Firestore.instance.collection('dri_work_time').
                                          limit(10).snapshots(),
                                          builder: (context, snapshot) {
                                            if({items[index].SunToMon[12]}.contains('na')){
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
                                                      value: 12,
                                                      groupValue: _myTaskType,
                                                      onChanged: _handleTask),
                                                  Text(
                                                      "${items[index].SunToMon[12]}"),
                                                ],
                                              );
                                            }      })),

 DropdownButton<int>(
                                    items: [
                                      DropdownMenuItem<int>(
                                        child: Text("Inducesmile.com"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem<int>(
                                        child: Text("Flutter.dev"),
                                        value: 2,
                                      ),
                                      DropdownMenuItem<int>(
                                        child: Text("Dart.dev"),
                                        value: 3,
                                      ),
                                    ],
                                    isExpanded: false,
                                    onChanged: (int val) {},
                                    hint: Text('Select Website'),
                                  ),


                                  InkWell(onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (_)=> Page()));
                                            },
                                              child: Container(
                                                child: Image.network(
                                                  '${items[index].name}',
                                                ),
                                              ),
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value:
                                              selectedSizes.contains('Monday'),
                                          onChanged: (value) =>
                                              changeSelectedBox('Monday')),
                                      Text(
                                        'Monday: ${items[index].Monday[0]}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),


Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes.contains(
                                              'Monday: ${items[index].Monday[0]}'),
                                          onChanged: (value) => changeSelectedBox(
                                              'Monday: ${items[index].Monday[0]}')),
                                      Text(
                                        'Monday: ${items[index].Monday[0]}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes.contains(
                                              '${items[index].Tuesday[0]}'),
                                          onChanged: (value) =>
                                              changeSelectedBox(
                                                  '${items[index].Tuesday[0]}')),
                                      Text(
                                        'Tuesday: ${items[index].Tuesday[0]}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes.contains(
                                              '${items[index].Wednesday[0]}'),
                                          onChanged: (value) => changeSelectedBox(
                                              '${items[index].Wednesday[0]}')),
                                      Text(
                                        'Wednesday: ${items[index].Wednesday[0]}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes.contains(
                                              '${items[index].Thursday[0]}'),
                                          onChanged: (value) => changeSelectedBox(
                                              '${items[index].Thursday[0]}')),
                                      Text(
                                        'Thursday: ${items[index].Thursday[0]}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),


                                  //email below----checkbox
Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes.contains(
                                              '${items[index].email}'),
                                          onChanged: (value) =>
                                              changeSelectedBox(
                                                  '${items[index].email}')),

                                      Text(
                                        'email: ${items[index].email}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  //suntoMon below ----- Radio

                                  Row(
                                    children: <Widget>[
                                      Radio(groupValue: _myTaskType,
                                          value: selectedSizes.contains(
                                              '${items[index].SunToMon}'),
                                          onChanged: (value) =>
                                              changeSelectedBox(
                                                  '${items[index].SunToMon}')),

                                      Text(
                                        'SunToMon: ${items[index].SunToMon}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),

//if({items[index].SunToMon[0]} != null){

Container(

                                    child:  new StreamBuilder(
                                        stream: Firestore.instance.collection('dri_work_time').
                                        limit(10).snapshots(),
                                        builder: (context, snapshot) {

for(var i=0;i< 11;i++){
                                            return Row(
                                              children: <Widget>[

                                                Radio(
                                                    value: 1,
                                                    groupValue: _myTaskType,
                                                    onChanged: _handleTask),
                                                Text(
                                                    "${items[index].SunToMon[i].toString()}"),
                                              ],
                                            );
                                          };

                                          if({items[index].SunToMon[0]} == "12 pm" ){


                                            return new Row(
                                              children: <Widget>[
                                                Text("Driver not available")
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
                                                    "${items[index].SunToMon[0]}"),
                                              ],
                                            );
                                          }
                                        }),



Row(
                                        children: <Widget>[

                                        Radio(
                                            value: 1,
                                            groupValue: _myTaskType,
                                            onChanged: _handleTask),
                                        Text(
                                          "${items[index].SunToMon[10]}"),
                                      ],
                                    ),
                                  ),



                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 2,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[1]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 3,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[2]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 4,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[3]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 5,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[4]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 6,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[5]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 7,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[6]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 8,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[7]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 9,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[8]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 10,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[9]}"),
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 11,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon[10]}"),
                                    ],
                                  ),




 Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for(var item in list ) Text(item)
                                    ],
                                  ),


Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for(var item in x ) Text(item),
                                    ],
                                  ),



 Column(
                                    children: <Widget>[
                                      Radio(
                                          value: 1,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("${items[index].SunToMon}"),
                                    ],
                                  ),


                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          value: 21,
                                          groupValue: _myTaskType,
                                          onChanged: _handleTask),
                                      Text("4 pm "),
                                    ],
                                  ),


                                  Container(
                                    color: Colors.yellowAccent,
                                    child: Column(children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes
                                              .contains('Saturday'),
                                          onChanged: (value) =>
                                              changeSelectedBox('Saturday')),
                                      Text('Saturday : '),
                                      Text(
                                        '${items[index].Saturday}',
                                        //'${items[index].size[1]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    ]),
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
                                            createData();
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

// Below wala overrite krna h..........refer up :)
@override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 80,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return  SingleChildScrollView(
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
                                            InkWell(onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (_)=> Page()));

},
                                              child: Container(
                                                child: Image.network(
                                                  '${items[index].name}',
                                                ),
                                              ),
                                            ),


Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Visitor end'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Visitor end')),
                                                Text('Visitor end'),
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Admin end'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Admin end')),
                                                Text('Admin end'),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Sunday'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Sunday')),
                                                Text(
                                                    'Sunday: ${items[index].Sunday}',
                                                    //'${items[index].size[1]}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Monday'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Monday')),
                                                Text(
                                                  'Monday: ${items[index].Monday}',
                                                  //'${items[index].size[1]}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Tuesday'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Tuesday')),
                                                Text(
                                                  'Tuesday: ${items[index].Tuesday}',
                                                  //'${items[index].size[1]}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Wednesday'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Wednesday')),
                                                Text(
                                                  'Wednesday: ${items[index].Wednesday}',
                                                  //'${items[index].size[1]}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Thursday'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Thursday')),
                                                Text(
                                                  'Thursday: ${items[index].Thursday}',
                                                  //'${items[index].size[1]}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                    value: selectedBox
                                                        .contains('Friday'),
                                                    onChanged: (value) =>
                                                        changeSelectedBox(
                                                            'Friday')),
                                                Text(
                                                  'Friday: ${items[index].Friday}',
                                                  //'${items[index].size[1]}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            Container(color: Colors.yellowAccent,
                                              child: Column(
                                                  children:<Widget>[
                                                    Checkbox(
                                                        value: selectedBox
                                                            .contains('Saturday'),
                                                        onChanged: (value) =>
                                                            changeSelectedBox(
                                                                'Saturday')),
                                                    Text('Saturday : '),
                                                    Text(
                                                      '${items[index].Saturday}',
                                                      //'${items[index].size[1]}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0),
                                                    ),

                                         ]),
                                            ),
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
            ),
          ],
        ),
      ),
    );
  }

  void changeSelectedBox(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }
}
*/
