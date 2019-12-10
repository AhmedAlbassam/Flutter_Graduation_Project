import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gproject2020/Scanner.dart';
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
  ScrollController _scroll;

  _getEvent() async{
    Query q = _firestore.collection('Events').orderBy("eventName");
    QuerySnapshot _querysnap = await q.getDocuments();
      setState(() {
        _events = _querysnap.documents;
      });

  }
  void initState(){
    super.initState();
    _getEvent();
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color : Colors.white,
                image: DecorationImage(
                    image: ExactAssetImage('assets/images/events.jpg'),

                  ),
              ),
            ),
            ListTile(
              title: Text('Wallet', style: TextStyle(color: Color(0xff4C2F91), fontSize: 20),),
              leading: new Icon(Icons.account_balance_wallet ,color: Color(0xff4C2F91),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Wallet(),
                ));
              },
            ),
            ListTile(
              title: Text('Tickets', style: TextStyle(color: Color(0xff4C2F91),fontSize: 20),),
              leading: new Icon(Icons.event_note , color: Color(0xff4C2F91)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TicketState(),
                ));
              },
            ),
            ListTile(
              title: Text('Signout',style: TextStyle(color: Color(0xff4C2F91),fontSize: 20),),
              leading: new Icon(Icons.arrow_back , color: Color(0xff4C2F91),),
              onTap: (){
              _signOut();
              },
            ),
          ],
        ),
      ),

      appBar: new AppBar(
        title: Text(' All Events' , style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
          backgroundColor: Color(0xff4C2F91),
          elevation: 0.0,
         // iconTheme: new IconThemeData(color: Colors.white70),
      ),
      body:Container(
        child : _events.length == 0 ? Center(
          child: Text("there are no events available", style: TextStyle(fontSize: 20),),
        ) : ListView.builder(
            controller: _scroll,
            itemCount: _events.length,

            itemBuilder: (BuildContext ctx, int i){
              //
              String subtitle = "Location : "+_events[i].data['eventLocation']+ "\nDate : "+_events[i].data['eventDate'].toString() +"\nTicket Price : "+ _events[i].data['Ticket Price'].toString()+" SAR";
              String img = 'http://spmodels.net/malacca/wp-content/uploads/2016/01/Event-Management-service-AnnualDinner.jpg';

              if(_events[i].data['eventType']=="Sport"){
                 img = 'https://png.pngtree.com/png-clipart/20190613/original/pngtree-grunge-game-design-png-image_3572691.jpg';
              }else if(_events[i].data['eventType']=="General"){
                 img = 'http://spmodels.net/malacca/wp-content/uploads/2016/01/Event-Management-service-AnnualDinner.jpg';
              }else if(_events[i].data['eventType'] == "Entertainment"){
                 img = 'http://www.partyfanatics.net/wp-content/uploads/balloons-trans.png';

              }else if(_events[i].data['eventType']=="Conference"){
                 img = 'https://thestarsydney.files.wordpress.com/2015/08/mlf15_star_event_centre_00048.jpg';
              }else{
                 img = 'http://spmodels.net/malacca/wp-content/uploads/2016/01/Event-Management-service-AnnualDinner.jpg';
              }
              return Card (
                elevation: 10,
                color: Colors.white70,
                child:  ListTile(
                  dense: false,
                leading:  CircleAvatar( backgroundImage: NetworkImage(img),radius: 25,) ,
                title:Text( _events[i].data['eventName'],style: TextStyle(fontSize: 22,color:Colors.deepPurpleAccent),),
                subtitle: Text(subtitle , style: TextStyle(fontSize: 15 ,color: Colors.grey[800] ),),
                trailing : _events[i].data['Number of tickets'] == 0 ||  _events[i].data['Number of tickets'] == null
                    ? Icon(Icons.cancel, color: Colors.redAccent,size: 30,) : Icon(Icons.done, color: Colors.teal, size: 30,),
                onTap:(){
                  _events[i].data['Number of tickets'] == "0" ||  _events[i].data['Number of tickets'] == null
                  ? noTickets() :
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  Event(_events[i].data['eventName'],_events[i].data['eventLocation'],
                        _events[i].data['eventType'],
                        _events[i].data['eventDate'],_events[i].data['Number of tickets'],
                        _events[i].data['Ticket Price'], _events[i].data['eventDecscription']),




                  ));
                },
                //
                //   trailing: ,
              ),
              );
            }),
      ),
      ),

    );
  }
  noTickets(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text('Something went Wrong' , style: TextStyle(color: Colors.red),),
            content: new Text(' no more Tickets left', style: TextStyle(color: Colors.lightBlue),),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Close', style: TextStyle(color: Colors.lightBlue),)
              )
            ],

          );
        }
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