import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gproject2020/Organization.dart';
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

    return  Column(
        children: [
              eventImage(),
              eventDetails(),
              sizedBox(),
              participate(),
            ]
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
        return Container(
          color: Colors.deepPurpleAccent,
          height: 125,
          child : Card(
            semanticContainer: false,
            child: ListTile(
              title:Text( '$_name',style: TextStyle(fontSize: 25,color:Colors.deepPurpleAccent),),
              subtitle: Text('Location: $_location' +'\nDate: $_date' + '\nType: $_type' + '\n Tickekts remained: $_numoft' , style: TextStyle(fontSize: 15 ,color: Colors.grey[800] ),),

            ),
          ),
        );
      }
    Widget sizedBox(){
    return SizedBox(
      height: 10,
    );
    }
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
        child:Text('See who Participates in this event ',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal)),

      ),
        ),

    ],

    );
  }

}

// Text('Participate',style: TextStyle(color: Colors.white),),