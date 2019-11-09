import 'package:flutter/material.dart';
import 'package:gproject2020/Participate.dart' as prefix0;
import 'package:gproject2020/home.dart' as pre;
import 'Participate.dart';
import 'Ticket.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CreateAccount.dart';
class Event extends StatelessWidget{
  final _name, _location, _type, _date, _numoft, ticketPrice;


  Event(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice);

  Widget build(BuildContext context){

    return MaterialApp(

        home: Scaffold(

          body: EventPage(this._name, this._location,this._type, this._date, this._numoft, this.ticketPrice),
          backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title : Text('Event details', textAlign: TextAlign.center,),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),

          ),

        )
    );
  }
}
class EventPage extends StatefulWidget{
  final _name, _location, _type, _date, _numoft, ticketPrice;


  EventPage(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Eventstates(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice);
  }
}
class Eventstates extends State<EventPage>  {
  int ticketQnt = 1;
  var _name,_location, _type, _date, _numoft, ticketPrice;
  var _ticketId = 0;
  var rand = new Random();
  var _indiEmail = "";
  int bal;
  int totalPrice;
  Eventstates(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice);
  final db = Firestore.instance;
  Future<void> addTicket() async {
    _ticketId =rand.nextInt(999999);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    _indiEmail = user.email;

    try {
      await db.collection("Tickets").add(
          {
            'ticketNo': _ticketId,
            'eventName': _name,
            'Edate': _date,
            'eventLoc': _location,
            'indiEmail': _indiEmail,
            'TicketQnt': ticketQnt,

          }
      );
    } catch (e) {
      print(e.message);
    }

    print('Added? is it here?');
  }
String balString;
DocumentSnapshot userDoc;
DocumentSnapshot eventDoc;
  void readData()async{
    print(_name);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    _indiEmail = user.email;
  final documents = await db.collection('Account').getDocuments(); // getting all the documents
    for(int i=0;i < documents.documents.length;i++){
      if(documents.documents.elementAt(i).data.values.elementAt(0).toString().toLowerCase() == _indiEmail.toLowerCase()){
        userDoc = documents.documents.elementAt(i);

      }
    }
    bal = int.parse(userDoc.data.values.elementAt(2));
    print(bal);
    // setting the document for the user has finished, now we set the event document to update the Ticket qntity
    final eventDocuments = await db.collection("Events").getDocuments();
    print(eventDocuments.documents.first.data.values);
    for(int i=0;i < eventDocuments.documents.length;i++){
      if(eventDocuments.documents.elementAt(i).data.values.elementAt(2) == _name){
        eventDoc = eventDocuments.documents.elementAt(i);

      }
    }
    print(eventDoc.data.values);
    print(eventDoc.documentID);
  }
  DocumentSnapshot _currentDocument;
  TextEditingController _controller = TextEditingController();

  _updateData(int newBal) async {
    await db
        .collection('Account')
        .document(userDoc.documentID)
        .updateData({'balance': newBal.toString()});
    
    await db.collection('Events')
    .document(eventDoc.documentID)
    .updateData({'Number of tickets': (_numoft - ticketQnt)});
  }
  @override
  void initState() {
    readData();
    super.initState();
  }
  // String path = "C:\Users\moham\Desktop\Gproject\85871.jpg";
  Widget build(context) {

    return SingleChildScrollView (
        child : Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(

            children: [
              eventImage(),
              eventDetails(),
              ticketQnts(),
              priceTick(),
              buyButton(),
              participate(),
            ]
        ),
      ),
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
    return Column(
        children:[
          Text(

            '$_name' ,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic,),
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
              if(ticketQnt>=10)
                ticketQnt = 1;
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
  Widget priceTick(){
     totalPrice = ticketQnt*ticketPrice;
    return Text(
      'Price: $totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }
  checkbuy(){
    showDialog(context: context,
      builder: (BuildContext context){
      return AlertDialog(
        title: new Text('Something went Wrong' , style: TextStyle(color: Colors.red),),
        content: new Text('either unsufficent balance or no more Ticket left', style: TextStyle(color: Colors.lightBlue),),
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
  successfulbuy(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: new Text('Ticket bought succeffuly', style: TextStyle(color: Colors.lightBlue),),
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

  Widget buyButton(){
    print(bal);
    return RaisedButton(
      child: Text('Buy a Ticket',
        style: TextStyle(color: Colors.lightBlue),),
      onPressed: () {
        buyMethod(totalPrice);
      },
      color: Colors.white70,

    );
  }
  Widget buyMethod(int totalprice){
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: newBuy(totalprice),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Close', style: TextStyle(color: Colors.lightBlue),)
            ),
          ],
        );
      },
    );

  }
  Widget newBuy(int totalprice){
  return Container(
    width: 500, height:155,
    child: Column(
        children: <Widget>[
    Padding(
    padding: EdgeInsets.symmetric(vertical: 15.0),
    child: TextField(
      decoration: InputDecoration( labelText: 'Total price: $totalprice', labelStyle: TextStyle(color: Colors.lightBlue)),
      readOnly: true,
    ),
  ),
    Padding(

    padding: const EdgeInsets.all(8.0),
    child: RaisedButton(
    child: Text('purchase', style: TextStyle(color: Colors.white),),
    color: Colors.lightBlue,
    onPressed:(){
    if(ticketQnt >= _numoft || totalPrice > bal) {
    checkbuy();
    }
    else {
    addTicket();
    successfulbuy();
    _updateData((bal - totalPrice));
    }

    },
    ),
    ),
  ],
    ),

  );
  }
  Widget setBuy(){
    return Container(
      width: 500, height: 300,
      child: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              decoration: InputDecoration( labelText: 'Total price: $totalPrice'),
              readOnly: true,
            ),
          ),
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Buy a ticket', style: TextStyle(color: Colors.white),),
              color: Colors.lightBlue,
              onPressed:(){
                if(ticketQnt >= _numoft || totalPrice > bal) {
                  checkbuy();
                }
                else {
                  addTicket();
                  successfulbuy();
                  _updateData((bal - totalPrice));
                }

              },
            ),
          ),
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('Account').where("Email", isEqualTo: _indiEmail).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                       title:priceTick(),
                        trailing: RaisedButton(
                          child: Text("confirm", style: TextStyle(color: Colors.white)),
                          color: Colors.lightBlue,
                          onPressed: () async {
                            setState(() {
                              _currentDocument = doc;
                              _controller.text = totalPrice.toString();
                            });
                            //bal = doc.data['balance'].toString();
                          },

                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),

    );
  }
  Widget participate(){
    return RaisedButton(
      color: Colors.white,
          onPressed: (){

          },

      child: GestureDetector(

        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Participate(_name),
          ));
        },
        child:Text('Participate',
            style: TextStyle(color: Colors.orangeAccent, fontStyle: FontStyle.italic) ),

      ),


    );
  }
}

// Text('Participate',style: TextStyle(color: Colors.white),),