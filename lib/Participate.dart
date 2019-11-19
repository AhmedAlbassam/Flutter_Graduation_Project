import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Participate extends StatefulWidget {
  final _name;
  Participate(this._name);
  @override
  ParticipateState createState() => ParticipateState(this._name);
}
class ParticipateState extends State<Participate> with SingleTickerProviderStateMixin{
  final _name;
  ParticipateState(this._name);
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
        backgroundColor: Colors.deepPurpleAccent,
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
          Volunteer(this._name),BoothSeller(this._name)
        ],
        controller: _tabController,),
    );
  }
}
//=============================================================================================================================================================================

class Volunteer extends StatefulWidget {
  @override
  final _name;
  Volunteer(this._name);
  VolunteerState createState() {
    return VolunteerState(this._name);
  }
}
class VolunteerState extends State<Volunteer> {

final _name;
VolunteerState(this._name);
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
              'volExp':volExp,
              'eventName':_name,
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
      child : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Full name',
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
             EdgeInsets.symmetric(horizontal: 150,vertical: 25),
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(5),
              onPressed: (){addVol(); submitted();},
              child: Text('Submit' , style: TextStyle(color: Colors.white),),
            ),

          ),
        ],
      ),
    ),
    );
  }
submitted(){
  showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: new Text('Submitted successfully', style: TextStyle(color: Colors.deepPurpleAccent),),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Close', style: TextStyle(color: Colors.deepPurpleAccent),)
            )
          ],

        );
      }
  );
}
}
//=============================================================================================================================================================================
class BoothSeller extends StatefulWidget {
  final _name;
  BoothSeller(this._name);
  @override
  BoothSellerState createState() {
    return BoothSellerState(this._name);
  }
}
// Create a corresponding State class.
// This class holds data related to the form.
class BoothSellerState extends State<BoothSeller> {
final _name;
BoothSellerState(this._name);
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
              'Business Activity':activityType,
              'eventName':_name,
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
      child : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            padding:  const EdgeInsets.symmetric(horizontal: 150,vertical: 20),
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(5),
              onPressed: (){
                addBS();
                submitted();
              },
              child: Text('Submit', style: TextStyle(color: Colors.white),),
            ),
          ),

        ],
      ),
    ),
    );
  }
submitted(){
  showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: new Text('Submitted successfully', style: TextStyle(color: Colors.deepPurpleAccent),),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Close', style: TextStyle(color: Colors.deepPurpleAccent),)
            )
          ],

        );
      }
  );
}
}