import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'EventOrg.dart';
import 'home.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}
class _AddEventPageState extends State<AddEventPage> {


  final _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  var eventName;
  var eventType;
  var emailOfOrg;
  var eventDate;
  var eventLoc;
  var noOfTickets;
  var ticketPrice;
  //String email;


  Future<void> addEvent() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await db.collection("Events").add(
            {
              'eventName':eventName,
              'emailOrg':emailOfOrg,
              'eventType':eventType,
              'eventDate':eventDate,
              'eventLocation':eventLoc,
              'Number of tickets': noOfTickets,
              'Ticket Price': ticketPrice,
            }
        );
      } catch (e) {
        print(e.message);
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => Eventorg(eventName,eventLoc,eventType,eventDate,noOfTickets,emailOfOrg)));
    }

  }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor:Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey ,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),

              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Orgnazation Email'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter the Organazation email';
                  }
                  return null;
                },
                onSaved: (input) => emailOfOrg = input,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),

              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Event Name'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter event name';
                  }
                  return null;
                },
                onSaved: (input) => eventName = input,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),

              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Event Type'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter event type';
                  }
                  return null;
                },
                onSaved: (input) => eventType = input,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),

              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Event Date'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter event date';
                  }
                  return null;
                },
                onSaved: (input) => eventDate = input,
              ),
            ),

//
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Event Location'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter event Location';
                  }
                  return null;
                },
                onSaved: (input) => eventLoc = input,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Number of Tickets'),

                validator: (input){
                  if(input.isEmpty){
                    return 'please enter number of Tickets';
                  }
                  return null;
                },
                onSaved: (input) => noOfTickets = int.parse(input),
              ),
            ),
            /*Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),

                validator: (input){
                  if(input.isEmpty){
                    return 'please Email';
                  }
                  return null;
                },
                onSaved: (input) => email,
              ),
            ),*/
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Ticket Price'),
                onSaved: (input) => ticketPrice =int.parse(input),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(

                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        addEvent();
                        added();
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF2196F3),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Add Event",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),);
  }
  Widget added(){
    return AlertDialog(
      content: new Text('Added succeffuly', style: TextStyle(color: Colors.lightBlue),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Close', style: TextStyle(color: Colors.lightBlue),)
        )
      ],

    );
  }
}