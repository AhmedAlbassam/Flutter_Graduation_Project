import 'package:flutter/material.dart';
import 'CreateAccount.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

  void main() => runApp(mainClass());

class mainClass extends StatelessWidget {

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


    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<FirebaseUser> _handleSignIn() async {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential))
          .user;
      return user;

    }

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
                   Image.asset('assets/images/events.jpg',
                    height: 350.0,
                    width: 350.0,

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

                                color: Color(0xff4C2F91),
                                borderRadius: new BorderRadius.circular(9.0)),
                            child: new Text("Sign In With Email",
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white))),
                      ),
                    ),
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
                          _handleSignIn()
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e));
                        },
                        child: new Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: new BoxDecoration(
                                color: Colors.blue,
                                borderRadius: new BorderRadius.circular(9.0)),
                            child: new Text("Sign In With Google",
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white))),
                      ),
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