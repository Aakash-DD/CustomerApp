import 'package:flutter/material.dart';
import 'package:car1/rideDetails.dart';
import 'package:car1/select_time.dart';
import 'package:car1/task.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'task.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';
import 'package:car1/rideDetails.dart';
import 'package:car1/select_time.dart';
import 'package:car1/task.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'task.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';

class rideDetails extends StatefulWidget {
  @override
  _rideDetailsState createState() => _rideDetailsState();
}

class _rideDetailsState extends State<rideDetails> {
  String taskVal;
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return null;
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }

      final userId = appState?.firebaseUserAuth?.uid ?? '';
      final userIdLabel = Text('App Id: ');
      final number1 = appState?.user?.number ?? '';

      return Scaffold(
        appBar: AppBar(
          title: Text("Ride details"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    child: new StreamBuilder(
                        stream: Firestore.instance
                            .collection('booking_waiting')
                            .document('$number1')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading ..."),
                            );
                          } else {
                            //<DocumentSnapshot> ds= snapshot.data.documents;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Driver name: '),
                                        Text(snapshot.data["Driver_name"])
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Driver number: '),
                                        Text(snapshot.data["driverNumber"])
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Time: '),
                                        Text(snapshot.data["Time"])
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Status: '),
                                        Text(snapshot.data["Status"])
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                        })),
              ),
            ),
          ],
        ),
      );
    }
  }
}
