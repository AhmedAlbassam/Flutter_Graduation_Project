import 'package:flutter/material.dart';
import 'Participate.dart';
class Event extends StatelessWidget{

  Widget build(BuildContext context){

    return MaterialApp(

        home: Scaffold(

          body: EventPage(),
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title : Text('Event details', textAlign: TextAlign.center,),
            leading: BackButton(),



          ),

        )
    );
  }
}
class EventPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Eventstates();
  }
}
class Eventstates extends State<EventPage> {
  int ticketQnt = 1;
  String path = "C:\Users\moham\Desktop\Gproject\85871.jpg";
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
    return Text(
      'here the event name will be shown',
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
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
    return RaisedButton(
      child: Text('Buy a Ticket',
        style: TextStyle(color: Colors.white),),
      onPressed: (){},
      color: Colors.orangeAccent,

    );
  }
  Widget participate(){
    return RaisedButton(
      color: Colors.orangeAccent,
      child: GestureDetector(

          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => StartPage(),
            ));
          },
          child:Text('Participate',
            style: TextStyle(color: Colors.orangeAccent, fontStyle: FontStyle.italic) ),

      ),


    );
  }
}

// Text('Participate',style: TextStyle(color: Colors.white),),