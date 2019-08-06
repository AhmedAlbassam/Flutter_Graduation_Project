import 'package:flutter/material.dart';
import 'AddFunds.dart';
import 'addbeni.dart';
import 'TransferFunds.dart';
import 'withdraw.dart';
class Wallet extends StatelessWidget{

  Widget build(context){
    return MaterialApp(

        home: Scaffold(
          body:
          WalletPage(),

          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title : Text('Wallet', textAlign: TextAlign.center,),
            leading: BackButton(),



          ),
          backgroundColor: Colors.grey,
        )
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
    return Text('$bal', style: TextStyle(fontSize: 100),);
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
      child: Column(
        children: <Widget>[
          // first icon
          RaisedButton(
            child: Text('Transfer Money', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Transfer(),
      ));
    },
          ),
          RaisedButton(
            child: Text('add money', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Funds(),
              ));
            },
          ),
          RaisedButton(
            child: Text('withdraw Money', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => displaywithdraw(),
              ));
            },
          ),
          RaisedButton(
            child: Text('add beni', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => displayaddbeni(),
              ));
            },
          ),
        ],

      ),

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