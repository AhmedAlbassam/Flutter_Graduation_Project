import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateEvent extends StatefulWidget {
  final _EmailOrg;
  UpdateEvent(this._EmailOrg);

  @override
  _UpdateEventState createState() => _UpdateEventState(this._EmailOrg);
}
class _UpdateEventState extends State<UpdateEvent> {

  final  _EmailOrg;

  _UpdateEventState(this._EmailOrg);

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _loccontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _pricecontroller = TextEditingController();
  TextEditingController _noOfTktcontroller = TextEditingController();
  TextEditingController _typecontroller = TextEditingController();
  DocumentSnapshot _currentDocument;
  _updateData() async {
    await db
        .collection('Events')
        .document(_currentDocument.documentID)
        .updateData({'eventName': _namecontroller.text});
    await db
        .collection('Events')
        .document(_currentDocument.documentID)
        .updateData({'eventLocation': _loccontroller.text});
    await db
        .collection('Events')
        .document(_currentDocument.documentID)
        .updateData({'eventType': _typecontroller.text});

    await db
        .collection('Events')
        .document(_currentDocument.documentID)
        .updateData({'eventDate': _datecontroller.text});

    await db
        .collection('Events')
        .document(_currentDocument.documentID)
        .updateData({'Ticket Price': _pricecontroller.text});

    await db
        .collection('Events')
        .document(_currentDocument.documentID)
        .updateData({'Number of tickets': _noOfTktcontroller.text});


  }
  _deleteData()async{
    await db.collection("Events")
        .document(_currentDocument.documentID)
        .delete();
  }

  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Data from Firestore")),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('Events').where('emailOrg', isEqualTo : _EmailOrg).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        title: Text(doc.data['eventName']),
                        trailing: RaisedButton(
                          child: Text("Edit", style: TextStyle(color: Colors.white),),
                          color: Colors.red,
                          onPressed: () async {
                            setState(() {
                              _currentDocument = doc;
                              _namecontroller.text = doc.data['eventName'];
                            });
                          },

                        ),
                        leading: RaisedButton(
                          child: Text("delete",style: TextStyle(color: Colors.white)),
                          color: Colors.red,
                          onPressed: ()async{
                            setState(() {
                              _currentDocument = doc;
                              _namecontroller.text = doc.data['eventName'];
                            });
                            _deleteData();
                          },
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return SizedBox();
                }
              }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _namecontroller,
              decoration: InputDecoration(hintText: 'Enter Title'),
            ),

          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _loccontroller,
              decoration: InputDecoration(hintText: 'Enter loc'),
            ),

          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _typecontroller,
              decoration: InputDecoration(hintText: 'Enter type'),
            ),

          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _datecontroller,
              decoration: InputDecoration(hintText: 'Enter date'),
            ),

          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _pricecontroller,
              decoration: InputDecoration(hintText: 'Enter price'),
            ),

          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _noOfTktcontroller,
              decoration: InputDecoration(hintText: 'Enter numoftkt'),
            ),

          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Update'),
              color: Colors.red,
              onPressed: _updateData,
            ),
          ),
          SizedBox(height: 20.0),

        ],
      ),
    );


  }
  Widget successfulUpdate(){
    return AlertDialog(
      content: new Text('Event Updated succeffuly', style: TextStyle(color: Colors.lightBlue),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Close', style: TextStyle(color: Colors.lightBlue),)
        ),
      ],

    );
  }
  Widget deletedSuccessfully(){
    return AlertDialog(
      content: new Text('Event deleted succeffuly', style: TextStyle(color: Colors.lightBlue),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Close', style: TextStyle(color: Colors.lightBlue),)
        )
      ],

    );
  }
}
