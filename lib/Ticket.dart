import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TicketState extends StatefulWidget{

  Ticket createState() => new Ticket();
}
class Ticket extends State<TicketState> {

  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _tickets = [];
  bool _loadEvent = true;
  ScrollController _scroll;
  String current = "";
  _getEvent() async{

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    current = user.email;
    Query q = _firestore.collection('Tickets').where('indiEmail', isEqualTo: current );
    setState(() {
      _loadEvent =true;
    });

    QuerySnapshot _querysnap = await q.getDocuments();
    _tickets = _querysnap.documents;


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
        child : _tickets.length == 0 ? Center(
          child: Text("there are no Tickets"),
        ) : ListView.builder(
            controller: _scroll,
            itemCount: _tickets.length,
            itemBuilder: (BuildContext ctx, int i){
              String tickNo = _tickets[i].data['ticketNo'].toString();
              return ListTile (
                trailing: Icon(Icons.business),
                isThreeLine: true,
                title:Text('Ticket number: '+ tickNo,
                ),
                subtitle: Text('Event name: '+_tickets[i].data['eventName']+'\nDate: '+_tickets[i].data['Edate']
                    + '\nLocation: '+ _tickets[i].data['eventLoc']),
                //   trailing: ,
              );
            }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title : Text('My Tickets', textAlign: TextAlign.center,),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),

      ),

    );
  }

}
