import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';

import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/auth.dart';
import 'package:car1/regestration/util/validator.dart';
import 'package:car1/regestration/ui/widgets/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../firestoreservice.dart';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';
import '../../../task.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _location = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
/*
  int _myTaskType;
  String taskVal;
  StateModel appState;

  List<Task1> items2;
  FirestoreService1 fireServ = new FirestoreService1();
  StreamSubscription<QuerySnapshot> todoTasks1;


*/
  @override
  void initState() {
    super.initState();
  }
   /* items2 = new List();

    todoTasks1?.cancel();
    todoTasks1 = fireServ.getTaskList2().listen((QuerySnapshot snapshot) {
      final List<Task1> tasks = snapshot.documents
          .map((documentSnapshot) => Task1.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items2 = tasks;
      });
    });
  }
*/
  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _accountType = <String>[
    'Male',
    'Female',
  ];

  Widget build(BuildContext context) {



    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );

    final firstName = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _firstName,
      validator: Validator.validateName,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'First Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final lastName = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _lastName,
      validator: Validator.validateName,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final number = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _number,
      validator: Validator.validateNumber,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Phone number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final location = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _location,
      validator: Validator.validateName,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Location',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _emailSignUp(
              firstName: _firstName.text,
              lastName: _lastName.text,
              number: _number.text,
              location: _location.text,
              //fl:taskVal.toString(),
              w_fl:selectedCurrency,
              email: _email.text,
              password: _password.text,
              context: context);
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('SIGN UP', style: TextStyle(color: Colors.white)),
      ),
    );

    final signInLabel = FlatButton(
      child: Text(
        'Have an Account? Sign In.',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
    );
/*


    var userLocation1 ;
    */
/*= appState?.user?.location ?? '';
      final fl=userLocation1;
*//*


    //final Task1 items1 = ModalRoute.of(context).settings.arguments;
    final userIdLabel = Text('App Id: ');
    // final number = appState?.firebaseUserAuth?.uid ?? '';

    void _handleTask(int value) {
      setState(() {
        _myTaskType = value;

        switch (_myTaskType) {
          case 0:
            taskVal = '${items2[0].userLocation[0]}';
            break;
          case 1:
            taskVal = '${items2[0].userLocation[1]}';
            break;
          case 2:
            taskVal = '${items2[0].userLocation[2]}';
            break;
          case 3:
            taskVal = '${items2[0].userLocation[3]}';
            break;
          case 4:
            taskVal = '${items2[0].userLocation[4]}';
            break;
        */
/* case 5:
              taskVal = '${items2[1].userLocation[5]}';
              break;*//*

        */
/*case 6:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 7:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 8:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 9:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 10:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 11:
              taskVal = '${items2[1].userLocation[0]}';
              break;
            case 12:
              taskVal = '${items2[1].userLocation[0]}';
              break;*//*

        }
      });
    }
    setState(() {
      userLocation1 = taskVal;
    });

    createData() {
//      final userId = appState?.firebaseUserAuth?.uid ?? '';
      //   final number1 = appState?.user?.number ?? '';

      DocumentReference ds =
      Firestore.instance.collection('3').document(userLocation1);

      Map<String, dynamic> data = {
        //"Size": selectedSizes,
        "userLocation": userLocation1,
      };
      */
/*ds.get().whenComplete(action){
        if(data)
      };*//*

      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }

    createData2() {
//      final userId = appState?.firebaseUserAuth?.uid ?? '';
      //   final number1 = appState?.user?.number ?? '';

      DocumentReference ds =
      Firestore.instance.collection('3').document(userLocation1);

      Map<String, dynamic> data = {
        //"Size": selectedSizes,
        "ok2": userLocation1,
      };
      */
/*ds.get().whenComplete(action){
        if(data)
      };*//*

      ds.updateData(data).whenComplete(() {
        print('Task created');
      });
    }
*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      firstName,
                      SizedBox(height: 24.0),
                      lastName,
                      SizedBox(height: 24.0),
                      number,
                      SizedBox(height: 24.0),
                      location,
                      SizedBox(height: 24.0),
                      email,
                      SizedBox(height: 24.0),
                      password,
                      SizedBox(height: 12.0),
/*
                      Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text("Available timings of :"),
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 0,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${items2[0].userLocation[0]}"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 1,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${items2[0].userLocation[1]}"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 2,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${items2[0].userLocation[2]}"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 3,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${items2[0].userLocation[3]}"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 4,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${items2[0].userLocation[4]}"),
                                  ],
                                ),
                                *//*Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () {
                                        *//**//*setState(() {
                            userLocation1 = taskVal;
                          });*//*
                                *//*
                                        createData();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                             // builder: (_) => listProfile(),
                                              //settings: RouteSettings(),
                                            ));
                                      },
                                      child: Text("Confirm 1"),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () {

                                        createData2();

                                        *//**//*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => rideDetails(),
                                //settings: RouteSettings(),
                              ));*//**//*
                                      },
                                      child: Text("Confirm 2"),
                                    ),
                                  ],
                                )*//*
                              ],
                            ),
                          )
                        ],
                      ),*/
                    Form(
                      key: _formKeyValue,
                      autovalidate: true,
                      child: new Column(
//                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.male,
                                size: 25.0,
                                color: Color(0xff11b719),
                              ),
                              SizedBox(width: 50.0),
                              DropdownButton(
                                items: _accountType
                                    .map((value) => DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Color(0xff11b719)),
                                  ),
                                  value: value,
                                ))
                                    .toList(),
                                onChanged: (selectedAccountType) {
                                  print('$selectedAccountType');
                                  setState(() {
                                    selectedType = selectedAccountType;
                                  });
                                },
                                value: selectedType,
                                isExpanded: false,
                                hint: Text(
                                  'Choose Account Type',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40.0),
                          StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance.collection("driver1").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  const Text("Loading.....");
                                else {
                                  List<DropdownMenuItem> currencyItems = [];
                                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                                    DocumentSnapshot snap = snapshot.data.documents[i];
                                    currencyItems.add(
                                      DropdownMenuItem(
                                        child: Text(
                                          snap.documentID,
                                          style: TextStyle(color: Color(0xff11b719)),
                                        ),
                                        value: "${snap.documentID}",
                                      ),
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.coins,
                                          size: 25.0, color: Color(0xff11b719)),
                                      SizedBox(width: 50.0),
                                      DropdownButton(
                                        items: currencyItems,
                                        onChanged: (currencyValue) {
                                          final snackBar = SnackBar(
                                            content: Text(
                                              'Selected Currency value is $currencyValue',
                                              style: TextStyle(color: Color(0xff11b719)),
                                            ),
                                          );
                                          Scaffold.of(context).showSnackBar(snackBar);
                                          setState(() {
                                            selectedCurrency = currencyValue;
                                          });
                                        },
                                        value: selectedCurrency,
                                        isExpanded: false,
                                        hint: new Text(
                                          "Choose Currency Type",
                                          style: TextStyle(color: Color(0xff11b719)),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),

                        ],
                      ),
                    ),
                      signUpButton,
                      signInLabel,
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailSignUp(
      {String firstName,
        String lastName,
        String number,
        String location,
        String email,
        String password,
        String fl,
        String w_fl,
        BuildContext context, }) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((uID) {
          Auth.addUserSettingsDB(new User(
            userId: uID,
            email: email,
            firstName: firstName,
            lastName: lastName,
            number: number,
            location: location,
            fl:fl,
            w_fl:w_fl
          ));
        });
        //now automatically login user too
        //await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Sign Up Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
