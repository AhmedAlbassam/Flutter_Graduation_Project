import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class GenerateScreen extends StatelessWidget {
String indiemail;
GenerateScreen(this.indiemail);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - QR CODE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(indiemail),
    );
  }
}

class HomePage extends StatelessWidget {
  String indiemail;
  HomePage(this.indiemail);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR CODE"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Code generated with the text:\n $indiemail",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            SizedBox(height: 16,),

            QrImage(
              data: indiemail,
              gapless: true,
              size: 150,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
            RaisedButton(
                color: Colors.indigo[800],
                child: GestureDetector(
                  onTap: (){
                    QrImage();
                  },))
          ],
        ),
      ),
    );
  }
}