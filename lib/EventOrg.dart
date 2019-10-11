import 'package:flutter/material.dart';
import 'package:gproject2020/Participate.dart' as prefix0;
import 'package:gproject2020/home.dart' as pre;
import 'Participate.dart';
import 'home.dart';
import 'applicants.dart';
class Eventorg extends StatelessWidget{
  final _name, _location, _type, _date, _numoft;


  Eventorg(this._name, this._location,this._type, this._date,this._numoft);

  Widget build(BuildContext context){

    return MaterialApp(

        home: Scaffold(

          body: EventorgPage(this._name, this._location,this._type, this._date, this._numoft),
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title : Text('Event details for org', textAlign: TextAlign.center,),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),

          ),

        )
    );
  }
}
class EventorgPage extends StatefulWidget{
  final _name, _location, _type, _date,_numoft;

  EventorgPage(this._name, this._location,this._type, this._date,this._numoft);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Eventorgstates(this._name, this._location,this._type, this._date,this._numoft);
  }
}
class Eventorgstates extends State<EventorgPage> {
  int ticketQnt = 1;
  final _name,_location, _type, _date,_numoft;

  Eventorgstates(this._name, this._location,this._type, this._date,this._numoft);
  // String path = "C:\Users\moham\Desktop\Gproject\85871.jpg";
  Widget build(context) {

    return Container(

      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(

            children: [
              eventImage(),
              eventDetails(),
              ticketQnts(),
              buyButton(),
              participate(),
            ]
        ),
      ),

    );

  }
  Widget eventImage(){
    return Container(
      child : Image.network("https://i.pinimg.com/564x/b0/df/f0/b0dff0574f141d59c87f6067ea0fae37.jpg", width: 160, height: 160,),

    );
  }
  Widget eventDetails(){

    //i can use Textspan to make it longer with diffirent styles
    return Column(
        children:[
          Text(

            '$_name' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),

          Text(
            '$_location' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          Text(
            '$_type' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          Text(
            '$_date' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
        ]
    );
  }
  Widget ticketQnts(){
    return  Row(

      children: <Widget>[
        Expanded(
          child : Text('Qnt',
              style: TextStyle(fontSize: 30)
          ),
        ),

        Flexible(
          child: IconButton(icon:
          Icon(Icons.add), onPressed: () {
            setState(() {
              ticketQnt++;
            });
          },)

          ,),
        Flexible(
          child: Text('$ticketQnt', style: TextStyle(fontSize: 30),),
        ),
        Flexible(
            child: IconButton(icon:
            Icon(Icons.remove), onPressed: () {
              setState(() {
                ticketQnt--;
                if(ticketQnt<=1)
                  ticketQnt = 1;
              });
            },)
        ),

      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
  Widget buyButton(){
    var h = new pre.HomePage();
    return RaisedButton(
      child: Text('Buy a Ticket',
        style: TextStyle(color: Colors.white),),
      onPressed: (){

      },
      color: Colors.orangeAccent,

    );
  }
  Widget participate(){
    return RaisedButton(
      color: Colors.white,
      onPressed: () {

      }
      ,
      child: GestureDetector(

        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => applicantsPage(_name),
          ));
        },
        child:Text('Participate',
            style: TextStyle(color: Colors.orangeAccent, fontStyle: FontStyle.italic) ),

      ),


    );
  }
}

// Text('Participate',style: TextStyle(color: Colors.white),),