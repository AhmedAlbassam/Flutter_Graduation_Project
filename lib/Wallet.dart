import 'package:flutter/material.dart';
import 'AddFunds.dart';
import 'TransferFunds.dart';
class Wallet extends StatelessWidget{

  Widget build(context){
    return MaterialApp(
debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:
          WalletPage(),

          appBar: AppBar(
          automaticallyImplyLeading: true,
            backgroundColor: Colors.indigo[900],
            elevation: 0.0,
            title : Text('Wallet', textAlign: TextAlign.end,),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() {

              }
    ),

    ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
             label: Text("Scan"),
           backgroundColor: Colors.indigo[800],),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor: Colors.indigo[900],
        ),
    );
  }
}
class WalletPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Walletstates();
  }
}
class Walletstates extends State<WalletPage>{
  int bal=0;
  Widget build(context){
    return Container (
      margin: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            balance(),
            firstRow(),
          ],

        ),
      ),

    );
  }
  Widget balance(){

    return Text('$bal', style:TextStyle(color:Colors.white,fontSize: 100),);
  }
  /*Widget buttons(){
    return Column (
      children: <Widget>[
        RaisedButton(child:
          Text('Transfer Money', style: TextStyle(color: Colors.white),)
        ),
      ],
    );
  }*/

  Widget firstRow(){

    return Container(
      padding: EdgeInsets.only(top: 70),

      child: Column(


        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // first icon
          RaisedButton(
          color: Colors.indigo[800],
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Transfer(),));
              },
            child: Text('Transfer Funds', style:TextStyle(color:Colors.white)),
          ),
            onPressed: (){

            },
          ),

    RaisedButton(
      color: Colors.indigo[800],
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Funds(),));
        },
        child: Text('Add Funds', style:TextStyle(color:Colors.white)),

      ),
      onPressed: (){},
    ),
          RaisedButton(
            child: Text('Withdraw Balance', style:TextStyle(color:Colors.white)),
            color: Colors.indigo[800],
            onPressed: (){

            },
          ),
          RaisedButton(
            child: Text('Add Benificary', style:TextStyle(color:Colors.white)),
            color: Colors.indigo[800],
            onPressed: (){

            },


          ),
        ],
      ) ,

    );
  }
/*Widget secondRow(){
    return Container(
      child: Row(
      children: <Widget>[
        // first icon
        IconButton(icon: Icon(Icons.add), onPressed: (){

        }, tooltip: 'Transfer Money',iconSize: 50),
        // second icon
        IconButton(icon: Icon(Icons.add), onPressed: (){

        }, tooltip: 'withdraw Money',iconSize: 50, color: Colors.lightBlueAccent,)
      ],

          )

    );
  }*/
}