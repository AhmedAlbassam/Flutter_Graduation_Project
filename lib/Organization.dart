import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AddEvent.dart';
import 'Event.dart';
import 'EventOrg.dart';
import 'applicants.dart';
import 'login.dart';

//import 'package:firebase_database/firebase_database.dart';

class OrganizationPage extends StatefulWidget {
  @override
 // OrganizationPage();
  String userName;
   OrganizationPage(this.userName);

  _OrganizationPageState createState() => new _OrganizationPageState(this.userName);

}

class _OrganizationPageState extends State<OrganizationPage> {

  int _bottomNavIndex=0;
  @override

  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _events = [];
  bool _loadEvent = true;
  ScrollController _scroll;
 String userName;
 _OrganizationPageState(this.userName);


 _getEvent() async{
   print(userName+'this is my email ahmed ahmed');
    Query q = _firestore.collection('Events').where('emailOrg', isEqualTo: userName).orderBy("eventName").limit(100);


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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body:Container(
        child : _events.length == 0 ? Center(
          child: Text("there are no events available"),
        ) : ListView.builder(
            controller: _scroll,
            itemCount: _events.length,
            itemBuilder: (BuildContext ctx, int i){

              return ListTile (
                title:Text( _events[i].data['eventName'],

                ),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Eventorg(_events[i].data['eventName'],_events[i].data['eventLocation'],
                        _events[i].data['eventType'],
                        _events[i].data['eventDate'],_events[i].data['numOft']),

                  ));
                },
              );


            }),
      ),

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(userName),
              decoration: BoxDecoration(
                  color: Colors.blueGrey
              ),
            ),
            ListTile(
              title: Text('Add Event'),
              leading: new Icon(Icons.account_balance_wallet),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                 builder: (context) => AddEventPage(),
                ));
              },
            ),
//            ListTile(
//              title: Text('Event Applications'),
//              leading: new Icon(Icons.event_note),
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => applicantsPage(""),
//                ));
//              },
//            ),
            ListTile(
              title: Text('Settings'),
              leading: new Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                 // builder: (context) => ,
                ));
              },
            ),
          ],
        ),
      ),

      appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),

      //   body: MainContent(),

    );
  }

}