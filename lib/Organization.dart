import 'package:flutter/material.dart';
import 'AddEvent.dart';
import 'applicants.dart';
//import 'package:firebase_database/firebase_database.dart';
class OrganizationPage extends StatefulWidget {
  @override
  _OrganizationPageState createState() => new _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  int _bottomNavIndex=0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                  color: Colors.blueGrey
              ),
            ),
            ListTile(
              title: Text('Add Event'),
              leading: new Icon(Icons.account_balance_wallet),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                 builder: (context) => AddEventPage(),
                ));
              },
            ),
            ListTile(
              title: Text('Event Applications'),
              leading: new Icon(Icons.event_note),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => applicantsPage(),
                ));
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: new Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                 // builder: (context) => ,
                ));
              },
            )
          ],
        ),
      ),

      appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      //   body: MainContent(),

    );
  }

}