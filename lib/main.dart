import 'package:flutter/material.dart';
import 'login.dart';


void main() => runApp(QuickBee());

class QuickBee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      // Set Raleway as the default app font hahaha
      theme: ThemeData(

        fontFamily: 'Roboto',
      ),

      home: MyHomePage(),
    );
  }
}

  class MyHomePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  new Image.asset(
                    'Images/mainLogo.png',
                    height: 300.0,
                    width: 300.0,

                  ),
                ],
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                        },
                        child: new Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: new BoxDecoration(
                                color: Color(0xFF18D191),
                                borderRadius: new BorderRadius.circular(9.0)),
                            child: new Text("Sign In With Email",
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white))),
                      ),
                    ),
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 5.0, top: 10.0),
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF4364A1),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("FaceBook",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 20.0, top: 10.0),
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFFDF513B),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Google",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }