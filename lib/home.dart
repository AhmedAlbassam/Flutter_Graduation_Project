import 'package:flutter/material.dart';
import'Event.dart';
import 'Wallet.dart';
import "package:cloud_firestore/cloud_firestore.dart";
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

    _getEvent() async{
    Query q = _firestore.collection('Events').orderBy("eventType").limit(5);
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
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                  color: Colors.blueGrey
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
              title: Text('Settings'),
              leading: new Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  //builder: (context) => Wallet(),
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
        body: Container(
          child : _events.length == 0 ? Center(
            child: Text("there are no events available"),
          ) : ListView.builder(itemCount: _events.length,itemBuilder: (BuildContext ctx, int i){
                    
               return ListTile (
                 title:Text( _events[i].data['eventType']
                 ),
               );
          }),
        ),

    );
  }

}