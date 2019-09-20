import 'package:flutter/material.dart';
import'Event.dart';
import 'Wallet.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'Participate.dart';
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
        ScrollController _scroll = ScrollController();

        DocumentSnapshot _lastdoc;
        bool _gettingmoreEvents = false;
        bool _moreEventavaliable = true;

    _getEvent() async{
      print('Events are coming');
    Query q = _firestore.collection('Events').orderBy("eventName").limit(_events.length);
    setState(() {
       _loadEvent =true;
    });
    QuerySnapshot querysnap = await q.getDocuments();
     _events = querysnap.documents;
     _lastdoc = querysnap.documents[querysnap.documents.length-1];
     setState(() {
        _loadEvent =false;
     });
  }
  _getmoreEvent() async{
      print('More events coming');
      _gettingmoreEvents = true;

      if(_moreEventavaliable == false){
        return;
      }

      if(_gettingmoreEvents == true){
        return;
      }
    Query q = _firestore.collection('Events')
        .orderBy("eventName")
        .startAfter([_lastdoc.data["eventName"]])
        .limit(_events.length);
    QuerySnapshot querysnap = await q.getDocuments();
    if (querysnap.documents.length == 0) {
      _moreEventavaliable = false;
    }
    _lastdoc = querysnap.documents[querysnap.documents.length-1];
    _events.addAll( querysnap.documents);

    setState(() {
    });
      _gettingmoreEvents = false;
  }
  void initState(){
      super.initState();
      _getEvent();

      _scroll.addListener( (){
        double maxScroll = _scroll.position.maxScrollExtent;
        double currentScroll = _scroll.position.pixels;
        double delta = MediaQuery.of(context).size.height * 0.25;
        if(maxScroll-currentScroll <= delta) {
          _getmoreEvent();
        }

      });
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
                 // builder: (context) => Wallet(),
                ));
              },
            ),
            ListTile(
              title: Text('Testing Participate'),
              leading: new Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => StartPage(),
                ));
              },
            )
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

              title:Text( _events[i].data['eventName']),

              trailing : _events[i].data['Number of tickets'] == 0 ||  _events[i].data['Number of tickets'] == null
                  ? Icon(Icons.cancel, color: Colors.red,) : Icon(Icons.done, color: Colors.green,),

              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Event(_events[i].data['eventName'],
                        _events[i].data['eventLocation'],
                        _events[i].data['eventType'],
                        _events[i].data['eventDate'],
                        _events[i].data['Number of tickets']),

                ));
              },

            );
          }),
        ),

    );
  }

}