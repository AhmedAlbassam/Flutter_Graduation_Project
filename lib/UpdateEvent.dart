import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gproject2020/CRUD_Event.dart';
import 'AddEvent.dart';
import 'Event.dart';
import 'EventOrg.dart';
import 'applicants.dart';
import 'login.dart';
import 'EventOrg.dart';
import 'home.dart';

class UpdateEvent extends StatefulWidget {
  final _EmailOrg;
  UpdateEvent(this._EmailOrg);

  @override
  _UpdateEventState createState() => _UpdateEventState(this._EmailOrg);
}
class _UpdateEventState extends State<UpdateEvent> {

  final  _EmailOrg;


  _UpdateEventState(this._EmailOrg);


  final _formKey = GlobalKey<FormState>();
 // final db = Firestore.instance;
  var eventName;
  var eventType;
 // var emailOfOrg;
  var eventDate;
  var eventLoc;
  var noOfTickets;
  var ticketPrice;
  Firestore _firestore = Firestore.instance;
  bool _loadEvent = true;
  List<DocumentSnapshot> _events = [];

  TextEditingController _controller = TextEditingController();
  DocumentSnapshot _currentDocument;
  Stream events;







   UpdateDialoge(BuildContext context , selectedDoc) async{
  CRUDevent CRUD = new CRUDevent(_EmailOrg);

  return showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
    return AlertDialog(
      title: Text('Update' ,style: TextStyle(fontSize: 15.0),),
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Enter Event Name'),
            onChanged: (value){
              this.eventName = value;
            },
          ),
          SizedBox(height: 5.0,),
          TextField(
            decoration: InputDecoration(hintText: 'Enter event Location'),
            onChanged: (value){
              this.eventLoc =value;
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Enter event date'),
            onChanged: (value){
              this.eventDate =value;
            },
          ),TextField(
            decoration: InputDecoration(hintText: 'Enter new Ticket price'),
            onChanged: (value){
              this.ticketPrice =value;
            },
          ),TextField(
            decoration: InputDecoration(hintText: 'Enter amount of tickets'),
            onChanged: (value){
              this.noOfTickets =value;
            },
          ),TextField(
            decoration: InputDecoration(hintText: 'Enter event Type'),
            onChanged: (value){
              this.eventType =value;
            },
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('update'),
          textColor: Colors.cyan,
          onPressed: (){
            Navigator.of(context).pop();
            CRUD.UpdateData(selectedDoc
                ,{  'eventName':eventName,
              'eventType':eventType,
              'eventDate':eventDate,
              'eventLocation':eventLoc,
              'Number of tickets': noOfTickets,
              'Ticket Price': ticketPrice,}).then((result){

            });
          },
        )
      ],
    );
    }
  );
}

@override
void initState(){
  CRUDevent CRUD = new CRUDevent(_EmailOrg);
  CRUD.getEvent().then(( results){
     setState(() {
       events = results;
     });
  });

super.initState();
}

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){

            },
          )
        ],
          backgroundColor:Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      resizeToAvoidBottomPadding: false,
      body:_eventList()
    );
  }

  Widget _eventList(){
    CRUDevent CRUD = new CRUDevent(_EmailOrg);
  //  if(events != null){
        return StreamBuilder(
          stream: events,
            builder: (context,snapshot){
              return ListView.builder(itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context,i){
                  return ListTile(
                    title: Text(snapshot.data.documents[i].data['eventName']),
                    subtitle: Text(snapshot.data.documents[i].data['eventLocation']),
                    onTap: (){
                      UpdateDialoge(context, snapshot.data.documents[i].documentID);
                    },
                    onLongPress: (){
                      CRUD.DeleteData(snapshot.data.documents[i].documntID);
                    },
                  );
                },);
            },
        );
      //  }
      //  else{
        //  return Text("Loading , please wait");
      //  }
  }
}