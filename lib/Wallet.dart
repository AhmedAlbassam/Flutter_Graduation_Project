import 'package:flutter/material.dart';
import 'AddFunds.dart';
import 'TransferFunds.dart';
class Wallet extends StatelessWidget{

  Widget build(context){
    return MaterialApp(

        home: Scaffold(
          body:
          WalletPage(),

          appBar: AppBar(
          automaticallyImplyLeading: true,
            backgroundColor: Colors.lightBlueAccent,
            elevation: 0.0,
            title : Text('Wallet', textAlign: TextAlign.center,),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() {

              }
    ),

    ),
          backgroundColor: Colors.grey,
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
//            child: Text('Transfer Money', style:TextStyle(color:Colors.white)),
//            color: Colors.lightBlue,
//            onPressed:() {},
          color: Colors.lightBlue,

          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Transfer(),));
              },
            child: Text('Transfer Money', style:TextStyle(color:Colors.white)),
          ),
            onPressed: (){

            },
          ),
//



    RaisedButton(
      color: Colors.lightBlue,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Funds(),));
        },
        child: Text('Add Funds', style:TextStyle(color:Colors.white)),
      ),
      onPressed: (){},
    ),
          RaisedButton(
            child: Text('withdraw Money', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
            onPressed: (){

            },
          ),
          RaisedButton(
            child: Text('add beni', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
            onPressed: (){

            },
          ), RaisedButton(
            child: Text('Display QR Code', style:TextStyle(color:Colors.white)),
            color: Colors.lightBlue,
            onPressed: (){

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