/*
import 'package:flutter/material.dart';

import 'payment/check.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Integration"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            Text("Amount to be paid is: "),
            Text("RS 2500",style: TextStyle(fontWeight: FontWeight.bold),),

            RaisedButton(
              color: Colors.green,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CheckRazor(),
                ),
                    (Route<dynamic> route) => false,
              ),
              child: Text(
                "Pay Now",
              ),
            ),
          ],


        ),
      ),
    );
  }
}*/
