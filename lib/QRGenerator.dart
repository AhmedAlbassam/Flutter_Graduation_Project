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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Generate(indiemail),
        appBar: AppBar(
          title: Text('QR code'),
          backgroundColor: Color(0xff282d58),
        leading: IconButton(icon:Icon(Icons.arrow_back , color: Colors.white70,),
        onPressed:() => Navigator.pop(context, false)
        ),
    ),
      )
    );
  }
}

class Generate extends StatelessWidget {
  String indiemail;
  Generate(this.indiemail);
  @override
  Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            QrImage(
              data: indiemail,
              gapless: true,
              size: 300,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
          ],
        ),
      );


  }
}