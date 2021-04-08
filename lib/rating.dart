import 'package:flutter_rating/flutter_rating.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'list_profile.dart';
import 'package:car1/regestration/util/state_widget.dart';

class rating1 extends StatefulWidget {
  @override
  _rating1State createState() => _rating1State();
}

class _rating1State extends State<rating1> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  double rating = 5;
  int starCount = 5;
  String comment;
  String _name10;
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    getTaskName(tasknameU) {
      //taskname ---> address
      this.comment = tasknameU;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Rating"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Please give rating after completing your ride"),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                  top: 50.0,
                  bottom: 50.0,
                ),
                child: new StarRating(
                  size: 25.0,
                  rating: rating,
                  color: Colors.orange,
                  borderColor: Colors.grey,
                  starCount: starCount,
                  onRatingChanged: (rating) => setState(
                    () {
                      this.rating = rating;
                    },
                  ),
                ),
              ),
              new Text(
                "$rating stars",
                style: new TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Comment'),
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
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getNamePreferences10().then(updateName10);
    super.initState();
  }

  void updateName10(String name) {
    setState(() {
      this._name10 = name;
    });
  }

  confirm() {
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    final firstName = appState?.user?.firstName?? '';
    final number = appState?.user?.number ?? '';
   // final w_fl = appState?.user?.w_fl ?? '';
    DocumentReference ds = Firestore.instance
        .collection("reviews")
        .document(_name10) //driverNumber
        .collection("1")
        .document(number); //customerNumber---for rating to differentiate

    Map<String, dynamic> data = {
      "cName": firstName,
      "dRating": rating,
      "comment": comment,
    };
    ds.setData(data).whenComplete(() {
      print('Task created');
    });
  }

  Future check() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (comment != null) {
        // _formKey.currentState.reset();
        setState(() => isLoading = false);
        confirm();
        Fluttertoast.showToast(msg: 'Submitted');
        Navigator.pop(context);
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Comment something!');
      }
    }
  }
}
