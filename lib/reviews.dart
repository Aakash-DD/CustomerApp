import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car1/regestration/models/state.dart';
//import 'list_profile.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';

import 'list_profile.dart';

class reviews extends StatefulWidget {
  @override
  _reviewsState createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {

  String _name10="";   // _name -> driverNumber from list.dart
String _name20="";

/*
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("reviews")
        .document(_name10)                  // _name10 will take null
        .collection("1")
        .getDocuments();
    return qn.documents;
  }*/

  @override
  Widget build(BuildContext context) {
    StateModel appState;
    bool _loadingVisible = false;

    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    final firstname = appState?.user?.firstName?? '';
    //final w_fl = appState?.user?.w_fl ?? '';


    Future getPosts() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("reviews")
          .document(_name20)
          .collection("1")
          .getDocuments();
      return qn.documents;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews by riders"),
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
                      return Card(
                        child: ListTile(
                         /* onTap: () {
                            // page3(snapshot.data[index]);
                            navigateToDetail(snapshot.data[index]);
                          },*/
                          title: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text("${snapshot.data[index].data["cName"]} ",style: TextStyle(fontWeight: FontWeight.bold),),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("${snapshot.data[index].data["dRating"]} "),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellowAccent,
                                  ),
                                ],
                              ),
                              Text("comment :  ${snapshot.data[index].data["comment"]}"),
                              SizedBox(height: 10.0,),

                              SizedBox(height: 50.0,)
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
/*
  @override
  void initState() {
    getNamePreferences10().then(updateName10);
    super.initState();
  }

  void updateName10(String name10) {
    setState(() {
      this._name10 = name10;
    });
  }*/

  @override
  void initState() {
    getNamePreferences20().then(updateName20);
    super.initState();
  }

  void updateName20(String name20) {
    setState(() {
      this._name20 = name20;
    });
  }
}

/*
Cwgithw95h1CWDGYL58v

git pull/push https://oauth2:Cwgithw95h1CWDGYL58v@gitlab.com/headstrt/admin_dashboard.git
pull for check after clone
*/
