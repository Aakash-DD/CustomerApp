import 'package:car1/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:car1/regestration/models/state.dart';
import 'package:car1/regestration/util/state_widget.dart';
import 'package:car1/regestration/ui/screens/sign_in.dart';
import 'package:car1/regestration/ui/widgets/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../aboutus.dart';
import '../../../list_profile.dart';
import '../../../support.dart';
import '../../../yourBookings.dart';

const String testDevice = 'D157812E1D86041B619EC5F772FAE5E7';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      keywords: <String>['wallpapers', 'walls', 'amoled'],
      birthday: new DateTime.now(),
      childDirected: true);
  var selectedCurrency;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
//  String location2;
  BannerAd _bannerAd;

  StateModel appState;
  bool _loadingVisible = false;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-6930382800507841/2874266469",
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner event: $event");
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-6930382800507841~6231536470");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    appState = StateWidget
        .of(context)
        .state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }

//check for null https://stackoverflow.com/questions/49775261/check-null-in-ternary-operation
      final firstName = appState?.user?.firstName ?? '';
      final email = appState?.user?.email ?? '';

  /*    getTaskName(tasknameU) {
        this.location2 = tasknameU;
      }*/

      return Scaffold(
        appBar: AppBar(
          title: Text("deepbrothers"),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text(firstName),
                accountEmail: Text(email),
                currentAccountPicture: new CircleAvatar(
                  child: Text(
                    "dB",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      //fontSize: 50.0
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
                otherAccountsPictures: <Widget>[
                  new CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text("dB",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                title: Text("Home"),
              ),
              new ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new settings()),
                  );
                },
                leading: Icon(
                  Icons.settings,
                  color: Colors.lightBlue,
                ),
                title: Text("Settings"),
              ),
              new ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new aboutus()),
                  );
                },
                leading: Icon(
                  Icons.info,
                  color: Colors.lightBlue,
                ),
                title: Text("About Us"),
              ),
              new ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new support()),
                  );
                },
                leading: Icon(
                  Icons.headset_mic,
                  color: Colors.lightBlue,
                ),
                title: Text("Support"),
              ),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(Icons.close,
                  color: Colors.black,
                ),
                title: Text("Close"),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: LoadingScreen(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "deepbrothers",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: 32.0),
                          ),
                          //logo, // add logo
                          SizedBox(height: 20.0,),
                          Text("Welcome !"),
                          Text(
                            firstName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          SizedBox(height: 48.0),

                          //select location

                      /*    Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration:
                              InputDecoration(labelText: 'Enter your address'),
                              onChanged: (String name) {
                                getTaskName(name);
                              },
                            ),
                          ),*/
                          SizedBox(height: 12.0),

                          Form(
                            key: _formKeyValue,
                            autovalidate: true,
                            child: new Column(
//                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                /*Row(
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
                                        'Choose your gender',
                                        style: TextStyle(color: Color(0xff11b719)),
                                      ),
                                    )
                                  ],
                                ),*/
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
                                            Icon(FontAwesomeIcons.locationArrow,
                                                size: 25.0, color: Color(0xff11b719)),
                                            SizedBox(width: 50.0),
                                            DropdownButton(
                                              items: currencyItems,
                                              onChanged: (currencyValue) {
/*                                            final snackBar = SnackBar(       // to show snackbar
                                                  content: Text(
                                                    'Selected Currency value is $currencyValue',
                                                    style: TextStyle(color: Color(0xff11b719)),
                                                  ),
                                                );
                                                Scaffold.of(context).showSnackBar(snackBar);*/
                                                setState(() {
                                                  selectedCurrency = currencyValue;
                                                });
                                              },
                                              value: selectedCurrency,
                                              isExpanded: false,
                                              hint: new Text(
                                                "Choose your location",
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

                          SizedBox(height: 48.0),

                          RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () {
                              check();
                            /*  saveName();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => new listProfile()));*/
                            },
                            child: Text(
                              "Book new Rides",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          Text("In case of blank screen...no drivers around you",style: TextStyle(color: Colors.red),),
                          SizedBox(height: 29.0),
                          RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => new yourBookings()));
                            },
                            child: Text(
                              "Your bookings",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 48.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              inAsyncCall: _loadingVisible),
        );
    }
  }

  void saveName() {
    savedNamePreferences0(selectedCurrency).then((_) {});
  }

  Future check() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (selectedCurrency != null ) {
        // _formKey.currentState.reset();
        setState(() => isLoading = false);
        saveName();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => new listProfile()));
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Select your location');
      }
    }
  }
}


Future<bool> savedNamePreferences0(String name0) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name0", name0);
  return prefs.commit();
}

Future<String> getNamePreferences0() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name0 = prefs.getString("name0");
  return name0;
}
