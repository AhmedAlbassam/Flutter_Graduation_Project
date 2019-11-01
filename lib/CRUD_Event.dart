import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CRUDevent{

      final orgEmail;

      CRUDevent(this.orgEmail);

      final _formKey = GlobalKey<FormState>();
      // final db = Firestore.instance;
      var eventName;
      var eventType;
      var emailOfOrg;
      var eventDate;
      var eventLoc;
      int noOfTickets;
      int ticketPrice;
      String email;
      Firestore _firestore = Firestore.instance;
      bool _loadEvent = true;
      List<DocumentSnapshot> _events = [];

      TextEditingController _controller = TextEditingController();
      DocumentSnapshot _currentDocument;




    getEvent() async{
    return await  _firestore.collection('Events').where('emailOrg', isEqualTo: orgEmail).getDocuments();

  }
  UpdateData(SelectedDoc , NewValues) async {
    Firestore.instance.collection('Events').document(SelectedDoc).updateData(NewValues).catchError((e){
      print(e);
    });

  }

  DeleteData(docId){
    Firestore.instance.collection('Events').document(docId).delete().catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }


}