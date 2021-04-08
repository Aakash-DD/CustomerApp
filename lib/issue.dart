import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:car1/regestration/models/state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'list_profile.dart';
import 'package:car1/regestration/util/state_widget.dart';

class issue extends StatefulWidget {
  @override
  _issueState createState() => _issueState();
}

class _issueState extends State<issue> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String issue1;
  StateModel appState;
  bool _loadingVisible = false;
  String _name; //here _name is time defines here (_name is private, valid here only in issue class) but refference (of getNamePreferences() only) comes from list.dart

  @override
  Widget build(BuildContext context) {
    getTaskName(tasknameU) {
      //taskname ---> address
      this.issue1 = tasknameU;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Issue"),
      ),
      body: Form(
        key: _formKey ,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Please describe you issue at"),
                      ),
                      SizedBox(height: 1.0,),
                      Text(
                        "customerdb123@gmail.com",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(children: <Widget>[
                        Expanded(child: Divider()),
                        Container(
                            child: Center(
                                child: Text(
                              "OR",
                              style: TextStyle(fontSize: 20),
                            )),
                            width: 35,
                            height: 35,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFe0e0e0),
                                border: Border.all(color: Colors.black45))),
                        Expanded(child: Divider()),
                      ]),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Descibe your issue...'),
                                onChanged: (String name) {
                                  getTaskName(name);
                                },
                              ),
                            ],
                          )),
                      RaisedButton(
                        onPressed: () {
                          check();
                        },
                        child: Text("Submit"),
                      ),
                    ],
                  ),
              ),
              SizedBox(height: 50.0,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getNamePreferences().then(updateName);
    super.initState();
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }
  confirm() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM y - kk:mm:ss').format(now);

    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    final number = appState?.user?.number ?? '';
    //final w_fl = appState?.user?.w_fl ?? '';
    DocumentReference ds = Firestore.instance
        .collection("confirmed_c_rides2")
        .document(number) //{widget.post.data["driverNumber"]}
        .collection("1")
        .document("issue"); //customerNumber---for rating to differentiate
    // 9717292365 - Fri 24 Jan 2020 - 12:57:19
    Map<String, dynamic> data = {
      //"Status": firstName + " $lastName",
      "issue": issue1,
      "time": _name,
      "issueCreatedOn":formattedDate,
    };
    ds.setData(data).whenComplete(() {
      print('Task created');
    });
  }

  Future check() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if ( issue1!=null)  {
       // _formKey.currentState.reset();
        setState(() => isLoading = false);
        confirm();
        Fluttertoast.showToast(msg: 'Issue submitted');
        Navigator.pop(context);

      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Describe your issue');
      }
    }
  }
}
