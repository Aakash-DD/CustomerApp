import 'package:car1/rideDetails.dart';
import 'package:car1/select_time.dart';
import 'package:car1/task.dart';
import 'package:car1/userLocation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'task.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';

class yourBookings extends StatefulWidget {
  @override
  _yourBookingsState createState() => _yourBookingsState();
}

class _yourBookingsState extends State<yourBookings> {
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    final w_fl = appState?.user?.w_fl ?? '';
    final number = appState?.user?.number ?? '';
    final lastName = appState?.user?.lastName ?? '';

    Future getPosts() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("confirmed_c_rides2")
          .document(number)
          .collection("1")
          .getDocuments();
      return qn.documents;
    }
/*
    navigateToDetail(DocumentSnapshot post1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DetailPage(post: post1)));
    }*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Bookings :"),
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
                          /*onTap: () {
                            //  DetailPage(snapshot.data[index]);
                            navigateToDetail(snapshot.data[index]);
                          },*/
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
                                  "Number:  ${snapshot.data[index].data["driverNumber"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Status:  ${snapshot.data[index].data["status"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Time:  ${snapshot.data[index].data["time"]}"),
                              SizedBox(height: 10),
                              RaisedButton(
                                color: Colors.black,
                                onPressed: (){

                                },
                                child: Text("Cancel",style: TextStyle(color: Colors.white),),
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
}
