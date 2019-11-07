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
      debugShowCheckedModeBanner: false,
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
          backgroundColor: Colors.white70,
      appBar: AppBar(
         backgroundColor: Color(0xff282d58),
        title: Text("QR CODE", style: TextStyle(color: Colors.white70),),
    leading: IconButton(icon:Icon(Icons.arrow_back , color: Colors.white70,),
    onPressed:() => Navigator.pop(context, false), ),


      ),
      body: Center(
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Scan QR Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff282d58),
                fontSize: 24,
              ),
            ),

            SizedBox(height: 16,),

            QrImage(
              data: indiemail,
              gapless: true,
              size: 300,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
          ],
        ),
      ),

    );
  }
}