import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gproject2020/UpdateEvent.dart';
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

     String subtitle = "Location : "+_events[i].data['eventLocation']+ "\nDate : "+_events[i].data['eventDate'].toString() +"\nTickets remaining : "+ _events[i].data['Number of tickets'].toString();

              return  Card (
                elevation: 10,
                color: Colors.white70,
                child: ListTile(
                  leading: new Icon(Icons.event_note, color: Colors.deepPurpleAccent,),
                title:Text( _events[i].data['eventName'],
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepPurpleAccent,
                  ),

                ),

                subtitle: Text(subtitle),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Eventorg(_events[i].data['eventName'],_events[i].data['eventLocation'],
                        _events[i].data['eventType'],
                        _events[i].data['eventDate'],_events[i].data['numOft'],_events[i].data['emailOrg']),

                  ));
                },
              ),
              );


            }),
      ),

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              //child: Text(userName),
              decoration: BoxDecoration(
                color : Colors.white,
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/events.jpg'),

                ),
              ),
            ),
            ListTile(
              title: Text('Add Event' , style: TextStyle(color: Colors.deepPurpleAccent),),
              leading: new Icon(Icons.account_balance_wallet, color: Colors.deepPurpleAccent,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                 builder: (context) => AddEventPage(userName),
                ));
              },
            ),
            ListTile(
              title: Text('Manage Events' , style: TextStyle(color: Colors.deepPurpleAccent),),
              leading: new Icon(Icons.event_note , color: Colors.deepPurpleAccent) ,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UpdateEvent(userName),
                ));
              },
            ),
            ListTile(
              title: Text('Settings' , style: TextStyle(color: Colors.deepPurpleAccent)),
              leading: new Icon(Icons.settings ,color: Colors.deepPurpleAccent),
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
        title: Text('All Events', style: TextStyle(color: Colors.white),),
         // backgroundColor: Colors.indigo[800],
        backgroundColor: Colors.deepPurpleAccent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.white,//Color(0xFF18D191)
          )),

      //   body: MainContent(),

    );
  }

}