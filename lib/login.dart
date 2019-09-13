import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CreateAccount.dart';
import 'home.dart';
import 'Organization.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        backgroundColor: Colors.indigo[800],
        title: new Text("Login"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(text: "Individual",),
            new Tab(text: "Organization"
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          Individual(),Org()
        ],
        controller: _tabController,),
    );
  }
}

class Individual extends StatefulWidget {
  @override
  IndividualState createState() {
    return IndividualState();
  }
}

class IndividualState extends State<Individual> {

  final _formKey = GlobalKey<FormState>();
  String email ,password;


  Future<void> Signin() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      try {
        FirebaseUser user = (await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: email, password: password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.orange, //or set color with: Color(0xFF0000FF)
    ));
    return new Scaffold(
//
      body: Form(
       key: _formKey ,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,


          children: <Widget>[

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),

              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter your email';
                  }
                  return null;
                },
                onSaved: (input) => email = input,
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),

                validator: (input){

                  if(input.length < 6){
                    return 'please enter your Password Correctily';
                  }
                  return null;
                },
                onSaved: (input) => password = input,
              ),
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 10.0),
                    child: GestureDetector(
                      onTap: Signin,
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.indigo[900],
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Login",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 20.0, top: 10.0),
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: new Text("Forgot Password?",
                            style: new TextStyle(
                                fontSize: 17.0, color: Colors.indigo[900]))),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignupPage(),   //Here we have to call create account page .
                        ));
                      },
                      child: new Text("Create A New Account ",style: new TextStyle(
                          fontSize: 17.0, color: Colors.indigo[900],
                          fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
// ==================================================================================================================================>
class Org extends StatefulWidget {
  @override
  OrgState createState() {
    return OrgState();
  }
}

class OrgState extends State<Org> {
  final _formKey = GlobalKey<FormState>();
  String email ,password;
  Future<void> OrgSignIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      try {
        FirebaseUser user = (await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: email, password: password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.orange, //or set color with: Color(0xFF0000FF)
    ));
    return new Scaffold(
//
      body: Form(
        key: _formKey ,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,


          children: <Widget>[

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),

              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),

                validator: (input){

                  if(input.isEmpty){
                    return 'please enter your email';
                  }
                  return null;
                },
                onSaved: (input) => email = input,
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),

                validator: (input){

                  if(input.length < 6){
                    return 'please enter your Password Correctily';
                  }
                  return null;
                },
                onSaved: (input) => password = input,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 10.0),
                    child: GestureDetector(
                      onTap: OrgSignIn,
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.indigo[900],
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Login",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 20.0, top: 10.0),
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: new Text("Forgot Password?",
                            style: new TextStyle(
                                fontSize: 17.0, color: Colors.indigo[900]))),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignupPage(),   //Here we have to call create account page .
                        ));
                      },
                      child: new Text("Create A New Account ",style: new TextStyle(
                          fontSize: 17.0, color: Colors.indigo[900],
                          fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}


