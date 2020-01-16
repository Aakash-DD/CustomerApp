import 'package:car1/payment2/main2.dart';
import 'package:car1/payment2/payment/check.dart';
import 'package:car1/payment2/payment/razorpay_flutter.dart';
import 'package:car1/payment2/paymentFailed.dart';
import 'package:car1/payment2/paymentSuccess.dart';
import 'package:car1/rideDetails.dart';
import 'package:car1/select_time.dart';
import 'package:car1/task.dart';
import 'package:car1/userLocation.dart';
import 'package:car1/yourBookings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'task.dart';
import 'dart:async';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';

class listProfile extends StatefulWidget {
  @override
  _listProfileState createState() => _listProfileState();
}

class _listProfileState extends State<listProfile> {
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    final w_fl = appState?.user?.w_fl ?? '';
    final firstName = appState?.user?.firstName ?? '';
    final lastName = appState?.user?.lastName ?? '';

    Future getPosts() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("driver2")
          .document(w_fl)
          .collection("1")
          .getDocuments();
      return qn.documents;
    }

    navigateToDetail(DocumentSnapshot post1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DetailPage(post: post1)));
    }

    page3(DocumentSnapshot post2) {
       MaterialPageRoute(builder: (_) => CheckRazor(post3: post2));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Bookings :"),
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
                          onTap: () {
                            page3(snapshot.data[index]);
                            navigateToDetail(snapshot.data[index]);
                          },
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
                                  "Number:  ${snapshot.data[index].data["driverNumber"]}")
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
class Logic {
  void doSomething() {
    print("doing something");
  }
}
class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  final Logic logic;

  DetailPage({this.post,this.logic});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool pressed = false;
  String taskname,tasksector,taskpocket,tasklandmark;
  int _myTaskType = 0;
  String taskVal;
  StateModel appState;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    /*createData() {
//      final userId = appState?.firebaseUserAuth?.uid ?? '';
      final number1 = appState?.user?.number ?? '';
      DocumentReference ds =
      Firestore.instance.collection('booking_waiting').document(items1.driverNumber);
      String status = "Waiting";
      Map<String, dynamic> tasks = {
        //"Size": selectedSizes,
        "Time": taskVal,
        "Driver_name": items1.firstName,
        "Status":status,
        "driverNumber": items1.driverNumber
        // "Driver name": ,
      };*/

    // firebase location to be set
    void confirm() { // for driver
      appState = StateWidget.of(context).state;
      //final userId = appState?.firebaseUserAuth?.uid ?? '';
      final w_fl = appState?.user?.w_fl ?? '';
      final firstName = appState?.user?.firstName ?? '';
      final number = appState?.user?.number ?? '';
      DocumentReference ds = Firestore.instance
          .collection("customer2")
          .document("${widget.post.data["driverNumber"]}")
          .collection("1")
          .document('1');

      Map<String, dynamic> data = {
        //"Status": firstName + " $lastName",
        "customerName":firstName,
        "customerNumber":number,
        "time":taskVal,
        "status": "Waiting...",
        "address":taskname,
        "sector":tasksector,
        "pocket":taskpocket,
        "landmark":tasklandmark,
        "payment":"X"
      };
      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }

    void confirm2() { // to fetched only on customer side i.e yourBookings
      appState = StateWidget.of(context).state;
      //final userId = appState?.firebaseUserAuth?.uid ?? '';
      final w_fl = appState?.user?.w_fl ?? '';
      final firstName = appState?.user?.firstName ?? '';
      final lastName = appState?.user?.lastName ?? '';
      final number = appState?.user?.number ?? '';
      DocumentReference ds = Firestore.instance
          .collection("confirmed_c_rides2")
          .document(number)
          .collection('1')
          .document('1');

      Map<String, dynamic> data = {
        //"Status": firstName + " $lastName",
        "carImage": "${widget.post.data["carImage"]}",
        "driverImage": "${widget.post.data["driverImage"]}",
        "experience": "${widget.post.data["experience"]}",
        "firstName": "${widget.post.data["driverName"]}",
        "gender": "${widget.post.data["gender"]}",
        "time": taskVal,
        "driverNumber": "${widget.post.data["driverNumber"]}",
        //"status": "Waiting..."
        "payment":"Complete your payment to confirm"
      };
      ds.setData(data).whenComplete(() {
        print('Task created');
      });
    }
//rohini......sector 11............

    void _handleTask(int value) {
      setState(() {
        _myTaskType = value;

        switch (_myTaskType) {
          case 0:
            taskVal = '${widget.post.data["time"][0]}}';
            break;
          case 1:
            taskVal = '${widget.post.data["time"][1]}}';
            break;
          case 2:
            taskVal = '${widget.post.data["time"][2]}';
            break;
          case 3:
            taskVal = '${widget.post.data["time"][3]}';
            break;
          case 4:
            taskVal = '${widget.post.data["time"][4]}';
            break;
          case 5:
            taskVal = '${widget.post.data["time"][5]}';
            break;
          case 6:
            taskVal = '${widget.post.data["time"][6]}';
            break;
          case 7:
            taskVal = '${widget.post.data["time"][7]}';
            break;
          case 8:
            taskVal = '${widget.post.data["time"][8]}';
            break;
          case 9:
            taskVal = '${widget.post.data["time"][9]}';
            break;
          case 10:
            taskVal = '${widget.post.data["time"][10]}';
            break;
          case 11:
            taskVal = '${widget.post.data["time"][11]}';
            break;
          case 12:
            taskVal = '${widget.post.data["time"][12]}';
            break;
          case 13:
            taskVal = '${widget.post.data["time"][13]}';
            break;
          case 14:
            taskVal = '${widget.post.data["time"][14]}';
            break;
        }
      });
    }
    getTaskName(tasknameU) {
      this.taskname = tasknameU;
    }
    getTaskSector(tasksectorU) {
      this.tasksector = tasksectorU;
    }
    getTaskPocket(tasknameU) {
      this.taskpocket = tasknameU;
    }
    getTasklandmark(tasknameU) {
      this.tasklandmark = tasknameU;
    }

    appState = StateWidget.of(context).state;
    final w_fl = appState?.user?.w_fl ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Timings :"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Enter your address"),
                      ],
                    ), TextField(
                          decoration: InputDecoration(labelText: 'Enter your address'),
                          onChanged: (String name) {
                            getTaskName(name);
                          },
                        ),
                      TextField(
                          decoration: InputDecoration(labelText: 'Sector'),
                          onChanged: (String name1) {
                            getTaskSector(name1);
                          },
                        ),

                    TextField(
                        decoration: InputDecoration(labelText: 'Pocket'),
                        onChanged: (String name2) {
                          getTaskPocket(name2);
                        },
                      ),
                    TextField(
                        decoration: InputDecoration(labelText: 'landmark'),
                        onChanged: (String name3) {
                          getTasklandmark(name3);
                        },
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.post.data["driverName"]),
                      ],
                    ),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][0]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 0,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][0]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][1]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 1,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][1]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][2]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 2,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][2]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][3]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 3,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][3]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][4]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 4,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][4]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][5]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 5,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][5]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][6]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 6,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][6]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][7]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 7,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][7]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][8]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 8,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][8]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][9]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 9,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][9]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][10]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 10,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][10]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][11]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 11,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][11]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][12]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 12,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][12]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][13]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 13,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][13]}"),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('driver2').document(w_fl).collection("1")

                                .snapshots(),
                            builder: (context, snapshot) {
                              if ({widget.post.data["time"][14]}
                                  .contains('N/A')) {
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
                                return Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 14,
                                        groupValue: _myTaskType,
                                        onChanged: _handleTask),
                                    Text("${widget.post.data["time"][14]}"),
                                  ],
                                );
                              }
                            })),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.post.data["Time"][0]),
                      ],
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () { logic.confirm();
                            //confirm();
                            confirm2();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => CheckRazor(),

                              ),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Text("Proceed to Pay"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*

class CheckRazor extends StatefulWidget {
  final DocumentSnapshot post3;

  CheckRazor({this.post3});

  @override
  _CheckRazorState createState() => _CheckRazorState();
}

class _CheckRazorState extends State<CheckRazor> {
  Razorpay _razorpay = Razorpay();
  var options;
  StateModel appState;
  bool _loadingVisible = false;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    //create3();
    confirm2();
    confirm();
    */
/*RaisedButton(

      onPressed: null,
      child: Text(" lolololol"),
    );*//*

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
          response: response,
        ),
      ),
          (Route<dynamic> route) => false,
    );
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
          response: response,
        ),
      ),
          (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options = {
      'key': "rzp_test_0RdOqxLBJnOCBb",
      // Enter the Key ID generated from the Dashboard

      'amount': 2500 * 100,
      //in the smallest currency sub-unit.
      'name': 'organization',

      'currency': "INR",
      'theme.color': "#F37254",
      'buttontext': "Pay with Razorpay",
      'description': 'RazorPay example',

      'prefill': {
        'contact': '',
        'email': '',
      },
      */
/*'external': {
        'wallets': ['paytm']
      },*//*

    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading... lolololoolololooollol",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }

  confirm() { // for driver
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    final w_fl = appState?.user?.w_fl ?? '';
    final firstName = appState?.user?.firstName ?? '';
    final number = appState?.user?.number ?? '';
    DocumentReference ds = Firestore.instance
        .collection("customer2")
        .document("${widget.post3.data["driverNumber"]}")
        .collection("1")
        .document('1');

    Map<String, dynamic> data = {
      //"Status": firstName + " $lastName",
      "payment":"payment done...",

    };
    ds.updateData(data).whenComplete(() {
      print('pay ment done...');
    });
  }

  confirm2() {

// to fetched only on customer side i.e yourBookings
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    */
/*final w_fl = appState?.user?.w_fl ?? '';
  final firstName = appState?.user?.firstName ?? '';
  final lastName = appState?.user?.lastName ?? '';*//*

    final number = appState?.user?.number ?? '';
    DocumentReference ds = Firestore.instance
        .collection("confirmed_c_rides2")
        .document(number)
        .collection('1')
        .document('1');

    Map<String, dynamic> data = {
      //"Status": firstName + " $lastName",
      "payment":"confirmed payment..."
    };
    ds.updateData(data).whenComplete(() {
      print('Task created');
    });
  }
}
*/
