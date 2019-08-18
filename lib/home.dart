import 'package:flutter/material.dart';
import'Event.dart';
import 'Wallet.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              title: Text('Wallet'),
              leading: new Icon(Icons.account_balance_wallet),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Wallet(),
                ));
              },
            ),
            ListTile(
              title: Text('Tickets'),
              leading: new Icon(Icons.event_note),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Wallet(),
                ));
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: new Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Wallet(),
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