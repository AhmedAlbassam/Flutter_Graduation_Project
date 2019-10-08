import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;

import 'home.dart';
import 'login.dart';



class SignupPage extends StatefulWidget {

  @override
  _SignupPageState createState() => _SignupPageState();

}

class _SignupPageState extends State<SignupPage> {


  String _email , _password;
  int date;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  var _balance = 0;
  var _QRcode = null;
  bool added = false;

  Future<FirebaseUser>  SignUp(String email , String password) async {

    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
    final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
      email: email,
      password: password)).user;
      user.sendEmailVerification();
      Navigator.of(context).pop();
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
      added = true;
    }
    }

  Future<void> addAcc(String email, String password) async {
    if (added == true) {
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        try {
          await db.collection("Account").add(
              {
                'Email': _email,
                'Password': _password,
                'balance': _balance,
                'QRcode': _QRcode,


              }
          );
        } catch (e) {
          print(e.message);
        }
      }
    }
    else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor:Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Color(0xFF18D191))
        ),
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: _formKey,
            child: Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[

//                    TextFormField(
//                    decoration: InputDecoration(
//                        labelText: 'Full name',
//                        labelStyle: TextStyle(
//                            fontFamily: 'Montserrat',
//                            fontWeight: FontWeight.bold,
//                            color: Colors.grey),
//                        //  hintText: 'example@example.com',
//                        focusedBorder: UnderlineInputBorder(
//                            borderSide: BorderSide(color: Colors.green))),
//
//
//                  ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                         //  hintText: 'example@example.com',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      validator: (input){

                        if(input.isEmpty){
                          return 'please enter your email';
                        }
                        return null;
                      },
                      onSaved: (input) => _email = input,

                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password ',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
                      ),
                      obscureText: true,

                      validator: (input){

                        if(input.length < 6){
                          return 'please enter your Password Correctly';
                        }
                        return null;
                      },
                      onSaved: (input) => _password = input,

                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Confirm password ',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                        obscureText: true
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.orangeAccent,
                          color: Colors.blueAccent,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: (){
                              SignUp(_email,_password); addAcc(_email,_password);
                            },
                            child: Center(
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),

                  ],
                ))));
  }
}