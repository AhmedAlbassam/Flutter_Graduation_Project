import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  @override
  initState() {
    super.initState();
  }
  _updateData(){

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
                          qr = code;
                        });
                      },
                      child: new Container(
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          //     border: Border.all(color: Colors.orange, width: 10.0, style: BorderStyle.solid),
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
              decoration: InputDecoration(hintText: 'Total price'),


            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Buy a ticket', style: TextStyle(color: Colors.white),),
              color: Colors.lightBlue,
              onPressed:() {
                _updateData();
              }
                  ),
          ),
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('Account').where("Email", isEqualTo: qr).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        title:Text(''),
                        trailing: RaisedButton(
                          child: Text("confirm", style: TextStyle(color: Colors.white)),
                          color: Colors.lightBlue,
                          onPressed: () async {
                            setState(() {
                              _currentDocument = doc;
                              //_controller.text = totalPrice.toString();
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
