import 'package:flutter/material.dart';
import 'package:gproject2020/Participate.dart' as prefix0;
import 'package:gproject2020/home.dart' as pre;
import 'Participate.dart';
import 'Ticket.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CreateAccount.dart';
import 'home.dart';
class Event extends StatelessWidget{
  final _name, _location, _type, _date, _numoft, ticketPrice, desc;


  Event(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice ,this.desc);

  Widget build(BuildContext context){

    return MaterialApp(
          debugShowCheckedModeBanner: false,
        home: Scaffold(
       backgroundColor: Colors.white,
          body: EventPage(this._name, this._location,this._type, this._date, this._numoft, this.ticketPrice,this.desc),
         // backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor:  Color(0xff4C2F91),
            title : Text('Event details', textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            leading: IconButton(icon:Icon(Icons.arrow_back , color: Colors.white,),
              onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),    //Navigator.pop(context, false),
            ),

          ),

        ),
    );
  }
}
class EventPage extends StatefulWidget{
  final _name, _location, _type, _date, _numoft, ticketPrice, desc;


  EventPage(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice,this.desc);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Eventstates(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice,this.desc);
  }
}
class Eventstates extends State<EventPage>  {
  int ticketQnt = 1;
  var _name,_location, _type, _date, _numoft, ticketPrice,desc;
  var _ticketId = 0;
  var rand = new Random();
  var _indiEmail = "";
  int bal;
  int totalPrice;
  Eventstates(this._name, this._location,this._type, this._date,this._numoft, this.ticketPrice,this.desc);
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
      if(eventDocuments.documents.elementAt(i).data.values.elementAt(3) == _name){
        eventDoc = eventDocuments.documents.elementAt(i);

      }
    }
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
    .updateData({'Number of tickets': (int.parse(_numoft) - ticketQnt).toString()});
  }
  @override
  void initState() {
    readData();
    super.initState();
  }
  // String path = "C:\Users\moham\Desktop\Gproject\85871.jpg";
  Widget build(context) {

    return SingleChildScrollView (

      child: Column(
            children: [
              eventImage(),
              description(),
              //ticketQnts(),
             priceTick(),
              buyButton(),

              ticketQnts(),
              //participate(),
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
    // Image.network(img, width: 160, height: 160,),
    return Container(
      color: Colors.deepPurpleAccent,
      height: 100,
        child : Card(
          semanticContainer: false,
      child: ListTile(
        //leading: CircleAvatar( backgroundImage: NetworkImage(img,  ),radius: 25, ) ,
        //leading: Image.asset('assets/images/sport.png',),
        leading: Image(image: NetworkImage(img),),
        title:Text( '$_name',style: TextStyle(fontSize: 25,color:Colors.deepPurpleAccent),),
        subtitle: Text('Location: $_location' +'\nDate: $_date' , style: TextStyle(fontSize: 15 ,color: Colors.grey[800] ),),

      ),
        ),
      );

  }
  Widget description(){
    return Container(
     // margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
     // color: Colors.amber,
      child: Text('$desc',
        style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),

      ),

    );
  }

  Widget ticketQnts(){
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.bottomCenter,
        //color: Colors.red,
      child: Row(
      children: <Widget>[
        Expanded(

          child : Text('Quantitiy',
              style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent), textAlign: TextAlign.right,
          ),
        ),

        Flexible(
          child: IconButton(icon:
          Icon(Icons.add, color: Colors.deepPurpleAccent,), onPressed: () {
            setState(() {
              if(ticketQnt>=10)
                ticketQnt = 1;
              ticketQnt++;
            });
          },)

          ,),
        Flexible(
          child: Text('$ticketQnt', style: TextStyle(fontSize: 30, color: Colors.deepPurpleAccent),),
        ),
        Flexible(
            child: IconButton(icon:
            Icon(Icons.remove, color: Colors.deepPurpleAccent,), onPressed: () {
              setState(() {
                ticketQnt--;
                if(ticketQnt<=1)
                  ticketQnt = 1;
              });
            },)
        ),

      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
    ),
    );
  }
  Widget priceTick(){
    totalPrice = ticketQnt* int.parse(ticketPrice);
    return Row(
      children: <Widget>[
        Padding(
      padding: EdgeInsets.only(top: 10),
      child :  Text(
      'Price: $totalPrice', style: TextStyle(
        color: Colors.white,
        fontSize: 20,

      backgroundColor: Colors.deepPurpleAccent,
    ),
     textAlign: TextAlign.left,
      ),
    ),
    ],
    );
  }
  checkbuy(){
    showDialog(context: context,
      builder: (BuildContext context){
      return AlertDialog(
        title: new Text('Something went Wrong' , style: TextStyle(color: Colors.red),),
        content: new Text('either unsufficent balance or no more Ticket left', style: TextStyle(color: Colors.deepPurpleAccent),),
        actions: <Widget>[
          new FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('Close', style: TextStyle(color: Colors.deepPurpleAccent),)
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
            content: new Text('Ticket bought succeffuly', style: TextStyle(color: Colors.deepPurpleAccent),),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Close', style: TextStyle(color: Colors.deepPurpleAccent),)
              )
            ],

          );
        }


    );
  }

  Widget buyButton(){
    print(bal);
    return Container(
      margin: EdgeInsets.all(10),
     // color: Colors.pink,
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            elevation: 20,
            child: Text('Buy a Ticket',
        style: TextStyle(color: Colors.white),),
        onPressed: () {
        buyMethod(totalPrice);
      },
        color: Colors.deepPurpleAccent,
          ),
    RaisedButton(
      elevation: 20,
    color: Colors.deepPurpleAccent,
    onPressed: (){},
      child: GestureDetector(
    onTap: () {
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => Participate(_name),
    ));
    },
    child:Text('Participate',
    style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic) ),

    ),


    ),

      ],
    ),
    );
  }
  Widget buyMethod(int totalprice){
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Confirm Payment' , style: TextStyle(color: Colors.deepPurpleAccent),),
          content: newBuy(totalprice),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Close', style: TextStyle(color: Colors.deepPurpleAccent),)
            ),
          ],
        );
      },
    );

  }
  Widget newBuy(int totalprice){
  return Container(
    width: 500, height:155,
    child : SingleChildScrollView(
    child: Column(
        children: <Widget>[
    Padding(
    padding: EdgeInsets.symmetric(vertical: 15.0),
    child: TextField(
      decoration: InputDecoration( labelText: 'Total price: $totalprice                  Quantity: $ticketQnt',
          labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
      readOnly: true,
    ),
  ),

    Padding(
      padding: const EdgeInsets.all(8.0),
    child: RaisedButton(
    child: Text('purchase', style: TextStyle(color: Colors.white),),
    color: Colors.deepPurpleAccent,
    onPressed:(){
    if(ticketQnt > int.parse(_numoft) || totalPrice > bal) {
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
                if(ticketQnt >= int.parse(_numoft) || totalPrice > bal) {
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
}

// Text('Participate',style: TextStyle(color: Colors.white),),