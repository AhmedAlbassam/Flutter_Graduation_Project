import 'package:flutter/material.dart';
import 'package:gproject2020/home.dart';
import 'addbeni.dart';
import 'AddFunds.dart';
import 'TransferFunds.dart';
import 'withdraw.dart';
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
            icon: Icon(Icons.camera_alt),
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
  String indiemail; int bal=0;
  Widget build(context){
    return Container (
      margin: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            balance(),firstRow(),

          ],
        ),
      ),
    );
  }
  _updateData() async {
    print("the email: $indiemail");
    await db
        .collection('Account')
        .document(_currentDocument.documentID)
        .updateData({'balance': _controller.text});

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
  String b;
    readData() async{
    final documents = await db.collection('Account').where('Email', isEqualTo: indiemail).getDocuments();
    final userObject = documents.documents.first.data;
    b = userObject.values.elementAt(2);
   int bal = int.parse(b);
    print(bal);
  }

  @override
  void initState() {
    getEmail();
    readData();
    super.initState();
  }
  Widget balance(){
    return Text('$bal', style:TextStyle(color:Colors.white,fontSize:50),);
  }

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

              },
            ),
          ),
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('Account').where("Email", isEqualTo: indiemail).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        title: Text('Balance: '+doc.data['balance'] ),
                        trailing: RaisedButton(
                          child: Text("Edit", style: TextStyle(color: Colors.white)),
                          color: Colors.lightBlue,
                          onPressed: () async {
                            setState(() {
                              _currentDocument = doc;
                              _controller.text = doc.data['balance'];
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


Widget balupdate(){
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

  Widget firstRow(){

    return Container(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
          color: Colors.indigo[800],
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Transfer(),));
              },
            child: Text('Transfer Funds', style:TextStyle(color:Colors.white)),
          ),
          ),
    RaisedButton(
      color: Colors.indigo[800],

        child: Text('Add Funds', style:TextStyle(color:Colors.white)),
      onPressed: (){
        print('working or not?');
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
          RaisedButton(

            color: Colors.indigo[800],
            child: GestureDetector(
              onTap: (){
                print('the Email: $indiemail');
                Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner(),));
              },
              child: Text('Add Beni', style:TextStyle(color:Colors.white)),
            ),
            onPressed: (){

            },
          ),
        ],
      ) ,
    );
  }

}
