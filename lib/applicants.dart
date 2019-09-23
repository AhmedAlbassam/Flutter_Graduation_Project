import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class applicantsPage extends StatefulWidget {
  @override
  _applicantsPageState createState() => _applicantsPageState();
}

class _applicantsPageState extends State<applicantsPage> with SingleTickerProviderStateMixin{
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
        title: new Text("Applicants"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(text: "Volunteers",),
            new Tab(text: "Booth Sellers"
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
           volApp(),bsApp()
        ],
        controller: _tabController,),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class volApp extends StatefulWidget {
  @override
  volAppState createState() {
    return volAppState();
  }
}
class volAppState extends State<volApp> {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _vol = [];
  bool _loadEvent = true;
  ScrollController _Scroll;



  _getVol() async{
    Query q = _firestore.collection('Volunteers').orderBy("volName").limit(100);
    setState(() {
      _loadEvent =true;
    });

    QuerySnapshot _volSnap = await q.getDocuments();
    _vol = _volSnap.documents;

    setState(() {
      _loadEvent =false;
    });
  }
  void initState(){
    super.initState();
    _getVol();
  }

  Widget build(BuildContext context) {
    return new Scaffold(

      body:Container(
        child : _vol.length == 0 ? Center(
          child: Text("there are no applicants"),
        ) : ListView.builder(
            controller: _Scroll,
            itemCount: _vol.length,
            itemBuilder: (BuildContext ctx, int i){

              return ListTile (
                trailing: Icon(Icons.accessibility_new),
                isThreeLine:true,
                title:Text( _vol[i].data['volName']
                ),
                subtitle: Text('Email: '+_vol[i].data['volEmail']+ " \nPhone Number:"+ _vol[i].data['volPhone']),


                //   trailing: ,
              );
            }),
      ),

    );
  }
}
// ==============================================================================================================================================================================>

class bsApp extends StatefulWidget {
  @override
  bsAppState createState() {
    return bsAppState();
  }
}
class bsAppState extends State<bsApp> {

  Firestore _fireStore = Firestore.instance;
  List<DocumentSnapshot> _bs = [];
  bool _loaderEvent = true;
  ScrollController _scroll;


  _getBS() async{
    Query p = _fireStore.collection('Booth Sellers').orderBy("bsName").limit(100);
    setState(() {
      _loaderEvent =true;
    });

    QuerySnapshot _volSnap = await p.getDocuments();
    _bs = _volSnap.documents;

    setState(() {
      _loaderEvent =false;
    });
  }
  void initState(){
    super.initState();
    _getBS();
  }

  Widget build(BuildContext context) {
    return new Scaffold(

      body:Container(
        child : _bs.length == 0 ? Center(
          child: Text("there are no applicants"),
        ) : ListView.builder(
            controller: _scroll,
            itemCount: _bs.length,
            itemBuilder: (BuildContext ctx, int i){

              return ListTile (
                trailing: Icon(Icons.business),
                isThreeLine: true,
                title:Text( _bs[i].data['bsName'],
                ),
                subtitle: Text('Email: '+_bs[i].data['bsEmail']+'\nPhone: '+_bs[i].data['bsPhone']

                ),
                //   trailing: ,
              );
            }),
      ),

    );
  }
}