import 'package:flutter/material.dart';
import 'package:gproject2020/home.dart';
import 'Scanner.dart';
import 'AddFunds.dart';
import 'QRGenerator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Wallet extends StatelessWidget{
  Widget build(context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:
          WalletPage(),
          appBar:AppBar(
          automaticallyImplyLeading: true,
            backgroundColor: Colors.indigo[900],
            elevation: 0.0,
            title : Text('Wallet', textAlign: TextAlign.end,),
            leading: IconButton(icon:Icon(Icons.arrow_back),
    ),
    ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt) ,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner(),));
          },
             label: Text("Scan"),
           backgroundColor: Colors.indigo[800],),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor: Colors.indigo[900],

        ),
    );
  }
}
class WalletPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Walletstates();
  }
}
class Walletstates extends State<WalletPage>{
  String balance;
  String indiemail; int bal=0; String oldbal;
  Widget build(context){
    return Container (
      margin: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            displayBalance(),firstRow(),

          ],
        ),
      ),
    );
  }
  int newbal;
  _updateData() async {
    print(realDoc.data.values.elementAt(2));
   String bala = realDoc.data.values.elementAt(2);
   bal = int.parse(bala);
    newbal = int.parse(_controller.text);
    int total = newbal + bal;
    print("the email: $indiemail");
    await db
        .collection('Account')
        .document(realDoc.documentID)
        .updateData({'balance': total.toString()});

  }
  Future <String> getEmail() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    indiemail = user.email;
    return indiemail;
  }
  TextEditingController _controller = TextEditingController();
  DocumentSnapshot _currentDocument;
  final db = Firestore.instance;
   String id;

  QuerySnapshot documents;
  DocumentSnapshot realDoc;

    readData() async{
     documents = await db.collection('Account').getDocuments();
    final userObject = documents.documents.first.data;

    // im getting the document reference now:
    for(int i=0;i < documents.documents.length;i++){
      if(documents.documents.elementAt(i).data.values.elementAt(0).toString().toLowerCase() == indiemail.toLowerCase()){
      realDoc = documents.documents.elementAt(i);
      }
      }
    setState(() {
       balance = realDoc.data.values.elementAt(2);
      });

      print(realDoc.documentID);
      print(realDoc.data.values.elementAt(1));
      print(indiemail);
      print(realDoc.data.values);
      print('this is the variable b: '+ balance);
  }

  getTheRealDocumentBitch(){
      for(int i=0;i<=3;i++){
        print(realDoc.data.values.elementAt(i));
      }
      print(realDoc.documentID);
      print(realDoc.data.values.elementAt(0));
      print("Alooooooo");
  }
  String getBalance(){
      print('this is for method getbalance()');
      print(realDoc.documentID);
      print(balance);
    balance = realDoc.data.values.elementAt(2);
    return balance;
  }

  @override
  void initState() {
    getEmail();
    readData();
    super.initState();

  }
  Widget displayBalance(){
      //getBalance();
      print('Bjjjijijialance is: $balance');
      return Text('$balance', style:TextStyle(color:Colors.white,fontSize:50),);}

  Widget setupdate(){
    return Container(
      width: 100, height: 300,
      child: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Add to Balance', style: TextStyle(color: Colors.white),),
              color: Colors.lightBlue,
              onPressed:(){
                _updateData();
                addedSuccess();
                setState(() {
                  int old = int.parse(balance); int newb = int.parse(_controller.text);
                  balance = (old + newb).toString();

                });

              },
            ),
          ),
          SizedBox(height: 20.0),

        ],
      ),

    );
  }


 balupdate(){
    showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        title: Text('Add balance'),
        content: setupdate(),
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
  addedSuccess(){
  showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: new Text('balance updated succeffuly', style: TextStyle(color: Colors.lightBlue),),
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
  Widget firstRow(){

    return Container(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
          color: Colors.indigo[800],
            child: Text('Transfer Funds', style:TextStyle(color:Colors.white)),
          /*child: GestureDetector(
            onTap: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context) => Transfer(),));
              },
            child: Text('Transfer Funds', style:TextStyle(color:Colors.white)),
          ),*/
            onPressed: (){
            getTheRealDocumentBitch();
            },
          ),
    RaisedButton(
      color: Colors.indigo[800],

        child: Text('Add Funds', style:TextStyle(color:Colors.white)),
      onPressed: (){
        balupdate();
      },
    ),
          RaisedButton(
            color: Colors.indigo[800],
            child: GestureDetector(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateScreen(indiemail)));
              },
              child: Text('QR', style:TextStyle(color:Colors.white)),
            ),
            onPressed: (){

            },
          ),
        ],
      ) ,
    );
  }

}
