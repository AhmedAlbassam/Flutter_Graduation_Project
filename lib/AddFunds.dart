import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

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


  @override
  initState() {
    super.initState();
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
                               border: Border.all(color: Colors.orange, width: 10.0, style: BorderStyle.solid),
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
}
