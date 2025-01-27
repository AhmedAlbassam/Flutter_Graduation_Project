import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Scanner.dart';
import 'home.dart';
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
            backgroundColor: Color(0xff282d58),
            elevation: 0.0,
            title : Text('Wallet', textAlign: TextAlign.end,style: TextStyle(color:Colors.white70),),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() =>  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)),
    ),
    ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt , color: Colors.white70,) , onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner(),));
          },
             label: Text("Scan",style:TextStyle(color:Colors.white70),),
           backgroundColor: Colors.indigo[500],),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor:Color(0xff282d58),

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
    return SingleChildScrollView (
      child : Container(
      margin: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
           imge(),
            //displayBalance(),
            firstRow(),

          ],
        ),
      ),
    ),
    );
  }
  Widget imge(){
    return SingleChildScrollView(
      child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50) ,
       child:Image( image: ExactAssetImage('assets/images/wallet.png'), height: 100, color: Colors.white70,),
        ),
        Padding(
          padding:EdgeInsets.fromLTRB(50, 0, 0, 50) ,
       child: Text('$balance', style:TextStyle(color:Colors.white70,fontSize:50 , height: 1.7) ,)
        ),

      ],

    ),
    );
  }
  int newbal;
  _updateData() async {
   String bala = realDoc.data.values.elementAt(1);
   bal = int.parse(bala);
    newbal = int.parse(_controller.text);
    int total = newbal + bal;
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
  final db = Firestore.instance;

  QuerySnapshot documents;
  DocumentSnapshot realDoc;
  readData() async{
     documents = await db.collection('Account').getDocuments();
    // im getting the document reference now:
    for(int i=0;i < documents.documents.length;i++){
      print(documents.documents.elementAt(i).data.values.elementAt(1));
      if(documents.documents.elementAt(i).data.values.elementAt(0).toString().toLowerCase() == indiemail.toLowerCase()){
      realDoc = documents.documents.elementAt(i);
      }
      }
    setState(() {
       balance = realDoc.data.values.elementAt(1);
      });


  }

  @override
  void initState() {
    getEmail();
    readData();
    super.initState();

  }
  Widget displayBalance(){
      //getBalance();
      return Text('$balance', style:TextStyle(color:Colors.white70,fontSize:50),);}

  Widget setupdate(){
    return Container(
      width: 100, height: 150,
      child: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              keyboardType: TextInputType.number,
              cursorColor: Color(0xff282d58),
              controller: _controller,
              decoration: InputDecoration(hintText: 'Amount' , ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Add to Balance', style: TextStyle(color: Colors.white70 )),
              color: Color(0xff282d58),
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
        title: Text('Add balance', style: TextStyle(color: Color(0xff282d58),)),
        content: setupdate(),
        actions: <Widget>[
          new FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('Close', style: TextStyle(color: Color(0xff282d58),),)
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
          content: new Text('balance updated succeffuly', style: TextStyle(color:Color(0xff282d58),),),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Close', style: TextStyle(color: Color(0xff282d58),),)
            )
          ],

        );
      }


  );
}
  Widget firstRow(){

    return Center(
      child : Container(
        padding: EdgeInsets.only(top: 70),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
        child:  ButtonTheme(
            minWidth: 100.0,
            height: 100,
      child: RaisedButton(
      color: Colors.white70,

        child: Text('Add Funds', style:TextStyle(color:Color(0xff282d58) ,  fontSize: 29)),
      onPressed: (){
        balupdate();
      },
    ),
    ),
      ),
          Padding(
            padding: const EdgeInsets.all(10.0),

         child: ButtonTheme(
            minWidth: 100.0,
            height: 100,

              child: RaisedButton(
                color: Colors.white70,
              child: Text('Display QR', style:TextStyle(color:Color(0xff282d58),  fontSize: 29)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateScreen(indiemail)));
                },
            ),


    ),
      ),
        ],
      ),
      ),
    );
  }

}
