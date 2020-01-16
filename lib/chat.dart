import 'package:car1/rides.dart';
import 'package:flutter/material.dart';

import 'chatScreen.dart';

class chat extends StatefulWidget {
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState(){
    //TODO implementation intiState
    super.initState();
    _tabController = new TabController(initialIndex: 0,length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WhatsApp"),
        elevation: 0.7,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white70,
          tabs: <Widget>[
            new Tab(text:"CHATS",),
            new Tab(text: "Your rides",),
          ],
        ),
        actions: <Widget>[
          new Icon(Icons.search),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
          new Icon(Icons.more_vert),
        ],
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Aakash"),
              accountEmail:Text("add@gmail.com"),
              currentAccountPicture: new CircleAvatar(child: Text("A",
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,
                    fontSize: 50.0),),),
              ),
            new ListTile(onTap: (){/*Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context)=> new PageOne(),
            ),);*/},
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            new ListTile(onTap: (){},
              leading: Icon(Icons.call),
              title: Text("Call Us"),
            ),
            new ListTile(onTap: (){},
              leading: Icon(Icons.star),
              title: Text("Rate Us"),
            ),
            new ListTile(onTap: (){
              Navigator.pop(context);
            },
              leading: Icon(Icons.close),
              title: Text("Close"),
            ),
          ],
        ),

      ),

      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
         // new ChatScreen(),
          new StatusScreen(),
        ],

      ),
    );
  }
}















