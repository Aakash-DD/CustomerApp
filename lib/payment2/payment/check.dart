import 'package:car1/list_profile.dart' as main;
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/models/user.dart';
import 'package:car1/regestration/util/state_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../paymentFailed.dart';
import '../paymentSuccess.dart';
import 'razorpay_flutter.dart';
import 'package:car1/list_profile.dart';

class CheckRazor extends StatefulWidget {

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
   /* MaterialButton(onPressed: () => confirm2(),
        child: Text("Log out"),color: Colors.orange);
   */
/*
    DetailPage.confirm();
    //confirm2();
    confirm();*/

    /*RaisedButton(

      onPressed: null,
      child: Text(" lolololol"),
    );*/
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
      /*'external': {
        'wallets': ['paytm']
      },*/
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

  /*confirm() { // for driver
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
      "payment":"payment done...",

    };
    ds.updateData(data).whenComplete(() {
      print('Task created');
    });
  }

  confirm2() {

// to fetched only on customer side i.e yourBookings
    appState = StateWidget.of(context).state;
    //final userId = appState?.firebaseUserAuth?.uid ?? '';
    *//*final w_fl = appState?.user?.w_fl ?? '';
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
  }*/
}
