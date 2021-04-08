import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'issue.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/util/state_widget.dart';
import 'rating.dart';

class yourBookings extends StatefulWidget {
  @override
  _yourBookingsState createState() => _yourBookingsState();
}

class _yourBookingsState extends State<yourBookings> {
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget
        .of(context)
        .state;
    final number = appState?.user?.number ?? '';

    Future getPosts() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("confirmed_c_rides2")
          .document(number)
          .collection("1")
          .getDocuments();
      return qn.documents;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Bookings :"),
      ),
      body: Container(
        child:FutureBuilder(
            future: getPosts(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading ..."),
                );
              } else {
                // ignore: unrelated_type_equality_checks
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      Widget image_carousel = new Container(
                        height: 200.0,
                        child: new Carousel(
                          //borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          boxFit: BoxFit.fitHeight,
                          images: [
                            Image.network(
                                "${snapshot.data[index].data["driverImage"]}"),
                            Image.network(
                                "${snapshot.data[index].data["carImage"]}")
                          ],
                          autoplay: true,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 4.0,
                          indicatorBgPadding: 6.0,
                          dotBgColor: Colors.transparent,
                        ),
                      );
                      return Card(
                        child: ListTile(
                          title: Column(
                            children: <Widget>[
                              Text(
                                "Status:  ${snapshot.data[index]
                                    .data["status"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              image_carousel,
                              SizedBox(height: 10),
                              Text(
                                  "Name:  ${snapshot.data[index]
                                      .data["driverName"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Gender:  ${snapshot.data[index]
                                      .data["gender"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Experience:  ${snapshot.data[index]
                                      .data["experience"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Number:  ${snapshot.data[index]
                                      .data["driverNumber"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Time:  ${snapshot.data[index]
                                      .data["time"]}"),
                              SizedBox(height: 10),
                              Text(
                                  "Scheduled on:  ${snapshot.data[index]
                                      .data["rideOn"]}"),
                              SizedBox(height: 10),
                              RaisedButton(
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => new issue()));
                                },
                                child: Text(
                                  "Having issue",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => rating1()));
                                },
                                child: Text("Rate driver"),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      );
                    });


                // ignore: unrelated_type_equality_checks
              }
              /*else {
                return Text("Book ur 1st ride now!");*/

            }),
      ),
    );
  }
}