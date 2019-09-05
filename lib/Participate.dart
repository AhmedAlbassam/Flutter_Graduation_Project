import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "New Task",
      theme: ThemeData(
          primaryColor: Colors.lightBlue
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        HomePage(),

        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title : Text('Participation', textAlign: TextAlign.center,),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          ),



        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(text: "Become a Volunteer",),
            new Tab(text: "Rent a Booth"
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          Volunteer(),BoothSeller()
        ],
        controller: _tabController,),
    );
  }
}
//=============================================================================================================================================================================

class Volunteer extends StatefulWidget {
  @override
  VolunteerState createState() {
    return VolunteerState();
  }
}
class VolunteerState extends State<Volunteer> {

  final _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  var volName;
  var volEmail;
  var volPhone;
  var volExp;

  Future<void> addVol() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await db.collection("Volunteers").add(
            {
              'volName':volName,
              'volEmail':volEmail,
              'volPhone':volPhone,
              'volExp':volExp
            }
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Full name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },  onSaved: (input) => volName = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Email'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },  onSaved: (input) => volEmail = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Phone Number'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },  onSaved: (input) => volPhone = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'have you volunteered before? If so, name the events'
            ),  onSaved: (input) => volExp = input,
            maxLines: 3,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 150,vertical: 50),
            child: RaisedButton(
              onPressed: addVol,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
//=============================================================================================================================================================================
class BoothSeller extends StatefulWidget {
  @override
  BoothSellerState createState() {
    return BoothSellerState();
  }
}
// Create a corresponding State class.
// This class holds data related to the form.
class BoothSellerState extends State<BoothSeller> {

  final _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  var bsName;
  var bsEmail;
  var bsPhone;
  var noOfBooth;
  var activityType;

  Future<void> addBS() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await db.collection("Booth Sellers").add(
            {
              'bsName':bsName,
              'bsEmail':bsEmail,
              'bsPhone':bsPhone,
              'Number of booths':noOfBooth,
              'Business Activity':activityType
            }
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Full Name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            }, onSaved: (input) => bsName = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Email'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            }, onSaved: (input) => bsEmail = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Phone Number'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            }, onSaved: (input) => bsPhone = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Number of booths'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            }, onSaved: (input) => noOfBooth = input,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Business activity'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            }, onSaved: (input) => activityType = input,
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 150,vertical: 50),
            child: RaisedButton(
              onPressed: addBS,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}