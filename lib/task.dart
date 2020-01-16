import 'package:flutter/material.dart';

class Task {
  String _firstName; // in driver for fetching string
  String _driverNumber;
  List<String> time = new List<String>();

  Task(this._firstName, this._driverNumber);

  Task.map(dynamic obj) {
    this._firstName = obj['firstName'];
    this._driverNumber = obj['driverNumber'];
  }

  String get firstName => _firstName;

  String get driverNumber => _driverNumber;

  Task.fromMap(Map<String, dynamic> map) {
    this._firstName = map['firstName'];
    this._driverNumber = map['driverNumber'];
    this.time = List.from(map['time']);
  }
}

class Task1 {
  //String _userLocation; // in driver for fetching string
  //String _driverNumber;
  List<String> userLocation = new List<String>();

  //Task(this._firstName, this._driverNumber);

  /*Task.map(dynamic obj) {
    this._firstName = obj['firstName'];
    this._driverNumber = obj['driverNumber'];
  }
*/
  /*String get firstName => _firstName;

  String get driverNumber => _driverNumber;
*/
  Task1.fromMap(Map<String, dynamic> map) {

    this.userLocation= List.from(map['userLocation']);
  }
}
