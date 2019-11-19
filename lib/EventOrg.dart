import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gproject2020/Organization.dart';
import 'package:gproject2020/Participate.dart' as prefix0;
import 'package:gproject2020/home.dart' as pre;
import 'Participate.dart';
import 'UpdateEvent.dart';
import 'home.dart';
import 'applicants.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Eventorg extends StatelessWidget{
  final _name, _location, _type, _date, _numoft,_emailorg;

  Eventorg(this._name, this._location,this._type, this._date,this._numoft,this._emailorg);

  Widget build(BuildContext context){

    return MaterialApp(
debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: EventorgPage(this._name, this._location,this._type, this._date, this._numoft,this._emailorg),
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title : Text('Event details', textAlign: TextAlign.center,),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => OrganizationPage(_emailorg),

                ));
              }
            ),

          ),

        )
    );
  }
}
class EventorgPage extends StatefulWidget{
  final _name, _location, _type, _date,_numoft,_emailorg;

  EventorgPage(this._name, this._location,this._type, this._date,this._numoft,this._emailorg);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Eventorgstates(this._name, this._location,this._type, this._date,this._numoft,this._emailorg);
  }
}
class Eventorgstates extends State<EventorgPage> {
  int ticketQnt = 1;
  final _name,_location, _type, _date,_numoft,_emailorg;
  Firestore _firestore = Firestore.instance;
  Eventorgstates(this._name, this._location,this._type, this._date,this._numoft,this._emailorg);
  // String path = "C:\Users\moham\Desktop\Gproject\85871.jpg";
  Widget build(context) {

    return Form(

      child: Column(

            children: [
              eventImage(),
              eventDetails(),
           ticketQnts(),
             // buyButton(),
              participate(),
              //EditEvent(),
              //DeleteEvent(),

            ]
        ),


    );

  }
  Widget eventImage(){
    String img = 'http://spmodels.net/malacca/wp-content/uploads/2016/01/Event-Management-service-AnnualDinner.jpg';

    if(_type=="Sport"){
      img = 'https://png.pngtree.com/png-clipart/20190613/original/pngtree-grunge-game-design-png-image_3572691.jpg';
    }else if(_type=="General"){
      img = 'http://spmodels.net/malacca/wp-content/uploads/2016/01/Event-Management-service-AnnualDinner.jpg';
    }else if(_type== "Entertainment"){
      img = 'http://www.partyfanatics.net/wp-content/uploads/balloons-trans.png';

    }else if(_type=="Conference"){
      img = 'https://thestarsydney.files.wordpress.com/2015/08/mlf15_star_event_centre_00048.jpg';
    }else{
      img = 'http://spmodels.net/malacca/wp-content/uploads/2016/01/Event-Management-service-AnnualDinner.jpg';
    }

    return Container(
      child : Image.network(img, width: 160, height: 160,),

    );
  }


  Widget eventDetails(){

    //i can use Textspan to make it longer with diffirent styles
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children:[
          Text(
            'Name: $_name' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.deepPurpleAccent),
          ),

          Text(
            'Location: $_location' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic , color: Colors.deepPurpleAccent),
          ),
          Text(
            'Type: $_type' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.deepPurpleAccent),
          ),
          Text(
            'Date: $_date' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic,color: Colors.deepPurpleAccent),
          ),
        ]
    ),
    );
  }
  Widget ticketQnts(){
    return  Row(

      children: <Widget>[
//        Expanded(
//          child : Text('Qnt',
//              style: TextStyle(fontSize: 30)
//          ),
//        ),

//        Flexible(
//          child: IconButton(icon:
//          Icon(Icons.add), onPressed: () {
//            setState(() {
//              ticketQnt++;
//            });
//          },)
//
//          ,),
//        Flexible(
//          child: Text('$ticketQnt', style: TextStyle(fontSize: 30),),
//        ),
//        Flexible(
//            child: IconButton(icon:
//            Icon(Icons.remove), onPressed: () {
//              setState(() {
//                ticketQnt--;
//                if(ticketQnt<=1)
//                  ticketQnt = 1;
//              });
//            },)
//        ),

      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
//  Widget buyButton(){
//    var h = new pre.HomePage();
//    return RaisedButton(
//      child: Text('Buy a Ticket',
//        style: TextStyle(color: Colors.white),),
//      onPressed: (){
//
//      },
//      color: Colors.orangeAccent,
//
//    );
//  }
  Widget participate(){
    return Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RaisedButton(
      color: Colors.deepPurpleAccent,
      onPressed: () {

      }
      ,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => applicantsPage(_name),
          ));
        },
        child:Text('See who are Participate in this event ',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal)),

      ),
        ),
    ],

    );
  }
 Widget EditEvent(){
    return RaisedButton(
      color: Colors.orangeAccent,
      onPressed: () {

      }
      ,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(

          builder: (context) => UpdateEvent(_emailorg),
          ));
        },
        child:Text('Edit your event information ',
            style: TextStyle(color: Colors.black87, fontStyle: FontStyle.normal)),

      ),



    );
  }

  Widget DeleteEvent(){
    DocumentSnapshot doc;
    return RaisedButton(
      color: Colors.redAccent,
      onPressed: () {

      }
      ,
      child: GestureDetector(
        onTap: ()async {
          await
          _firestore.collection('Events')
              .document(doc.documentID)
              .delete();
          
          Navigator.push(context, MaterialPageRoute(
       //   builder: (context) => OrganizationPage(),
          ));
        },
        child:Text('Delete your event ',
            style: TextStyle(color: Colors.black87, fontStyle: FontStyle.normal)),

      ),


    );
  }
}

// Text('Participate',style: TextStyle(color: Colors.white),),