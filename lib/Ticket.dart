import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TicketState extends StatefulWidget{

  Ticket createState() => new Ticket();
}
class Ticket extends State<TicketState> {

  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _tickets = [];
  ScrollController _scroll;
  String current = "";
  _getEvent() async{

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    current = user.email;
    Query q = _firestore.collection('Tickets').where('indiEmail', isEqualTo: current );

    QuerySnapshot _querysnap = await q.getDocuments();
    _tickets = _querysnap.documents;
    setState(() {
      _tickets = _querysnap.documents;
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
             int tickQnt = _tickets[i].data['TicketQnt'];
              if(tickQnt == null)
                tickQnt =1;
              return Card (
                elevation: 10,
                child : ListTile(
                leading: Icon(Icons.assignment,color: Color(0xff4C2F91),),
                trailing: Text('Qnt: '+ tickQnt.toString(), style:TextStyle(fontSize: 15 ,color: Colors.grey[800] ),),
                isThreeLine: true,
                title:Text('Ticket number: '+ tickNo ,style: TextStyle(fontSize: 22,color:Colors.deepPurpleAccent),),
                subtitle: Text('Event name: '+_tickets[i].data['eventName']+'\nDate: '+_tickets[i].data['Edate']
                    + '\nLocation: '+ _tickets[i].data['eventLoc'] , style:TextStyle(fontSize: 15 ,color: Colors.grey[800] ),),
                //   trailing: ,
              ),
              );
            }),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff4C2F91),
        title : Text('My Tickets', textAlign: TextAlign.center,style: TextStyle(color: Colors.white70,)),
        leading: IconButton(icon:Icon(Icons.arrow_back, color: Colors.white70,),
          onPressed:() => Navigator.pop(context, false),
        ),

      ),

    );
  }

}
