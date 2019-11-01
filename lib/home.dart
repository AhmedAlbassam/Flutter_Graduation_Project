import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gproject2020/addbeni.dart';
import'Event.dart';
import 'Wallet.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'Participate.dart';
import 'main.dart';
import 'Ticket.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // the scroll will be added in this class, and taken data from firebase that addded by org.
  int _bottomNavIndex=0;
  @override
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _events = [];
  bool _loadEvent = true;
  ScrollController _scroll;

  _getEvent() async{
    Query q = _firestore.collection('Events').orderBy("eventName").limit(100);
    setState(() {
      _loadEvent =true;
    });

    QuerySnapshot _querysnap = await q.getDocuments();
    _events = _querysnap.documents;

    setState(() {
      _loadEvent =false;
    });
  }


  void initState(){
    super.initState();
    _getEvent();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color : Colors.blueGrey
              ),
            ),
            ListTile(
              title: Text('Wallet'),
              leading: new Icon(Icons.account_balance_wallet),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Wallet(),
                ));
              },
            ),
            ListTile(
              title: Text('Tickets'),
              leading: new Icon(Icons.event_note),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TicketState(),
                ));
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: new Icon(Icons.settings),
              onTap: (){},
            ),
            ListTile(
              title: Text('SignOut'),
              leading: new Icon(Icons.arrow_back),
              onTap: (){

              },
            ),
          ],
        ),
      ),

      appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      body:Container(
        child : _events.length == 0 ? Center(
          child: Text("there are no events available"),
        ) : ListView.builder(
            controller: _scroll,
            itemCount: _events.length,
            itemBuilder: (BuildContext ctx, int i){
              return ListTile (
                title:Text( _events[i].data['eventName'],),
                trailing : _events[i].data['Number of tickets'] == 0 ||  _events[i].data['Number of tickets'] == null
                    ? Icon(Icons.cancel, color: Colors.red,) : Icon(Icons.done, color: Colors.green,),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Event(_events[i].data['eventName'],_events[i].data['eventLocation'],
                        _events[i].data['eventType'],
                        _events[i].data['eventDate'],_events[i].data['Number of tickets'],
                        _events[i].data['Ticket Price']),



                  ));
                },
                //   trailing: ,
              );
            }),
      ),

    );
  }
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Future<FirebaseUser> Function() user = FirebaseAuth.instance.currentUser;
    //print('$user');
    runApp(
        new MaterialApp(
          home: new MyHomePage(),
        )

    );
  }
}