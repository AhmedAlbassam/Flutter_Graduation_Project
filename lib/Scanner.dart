import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gproject2020/Wallet.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Scanner extends StatefulWidget {
  @override
  ScannerState createState() => new ScannerState();
}

class ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false ,
        home: new Scan());
  }
}

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<Scan> {
  String qr;
  bool camState = true;
  Firestore db = Firestore.instance;
  TextEditingController _controller = TextEditingController();
  DocumentSnapshot _currentDocument;
  DocumentSnapshot documentForTheCurrentUser;
  DocumentSnapshot documentForTheQRUser;
  String balString, indiemail;

  @override
  void initState() {
    getEmail();
    super.initState();
  }
  Future <String> getEmail() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    indiemail = user.email;
    return indiemail;
  }
  checkBuy(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text('Something went Wrong' , style: TextStyle(color: Colors.red),),
            content: new Text('unsufficent balance ', style: TextStyle(color: Colors.lightBlue),),
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
            content: new Text('succeffuly paid', style: TextStyle(color: Colors.lightBlue),),
            actions: <Widget>[
              new FlatButton(
                child: GestureDetector(
              onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => Wallet()));
          },
          child: Text('Close', style:TextStyle(color:Colors.lightBlue)),
              ),
              ),
            ],


          );
        }


    );
  }
// Navigator.of(context).pop();

  _updateData() async {
   final documents = await db.collection("Account").getDocuments();
    for(int i =0; i < documents.documents.length; i++){
      if(documents.documents.elementAt(i).data.values.elementAt(0) == indiemail){
        documentForTheCurrentUser = documents.documents.elementAt(i);

      }
      if(documents.documents.elementAt(i).data.values.elementAt(0) == qr){
        documentForTheQRUser = documents.documents.elementAt(i);

      }
    }
    int balforcuruser = int.parse(documentForTheCurrentUser.data.values.elementAt(2));
    int balforQruser = int.parse(documentForTheQRUser.data.values.elementAt(2));
    int amountfield = int.parse(_controller.text);
        if(amountfield > balforcuruser)
          checkBuy();
        else {
          await db
              .collection('Account')
              .document(documentForTheCurrentUser.documentID)
              .updateData(
              {'balance': (balforcuruser - amountfield).toString()});
          successfulbuy();
          await db
              .collection('Account')
              .document(documentForTheQRUser.documentID)
              .updateData({'balance': (amountfield + balforQruser).toString()});
        }

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //  backgroundColor: (Colors.black54),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            new Expanded(
                child: camState
                    ? new Center(
                  child: new SizedBox(
                    width: 400.0,
                    height: 500.0,
                    child: new QrCamera(
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      qrCodeCallback: (code) {
                        setState(() {
                         camState =false;
                          qr = code;
                          balupdate();
                        });

                      },
                      child: new Container(
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                        ),

                      ),
                    ),
                  ),
                )
                    : new Center(child: new Text("Camera inactive"))),
            new Text("QRCODE: $qr"),
          ],
        ),
      ),
    );

  }
  Widget balupdate(){
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Transfer Money'),
          content: setUpdate(),
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
  setUpdate(){
    return Container(
      width: 500, height: 300,
      child: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter price'),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Transfer', style: TextStyle(color: Colors.white),),
              color: Colors.lightBlue,
              onPressed:() {
               _updateData();
              }
                  ),
          ),
          SizedBox(height: 20.0),

        ],
      ),

    );
  }
}
