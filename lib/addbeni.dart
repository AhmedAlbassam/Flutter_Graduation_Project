import 'package:flutter/material.dart';

class displayaddbeni extends StatelessWidget{
  Widget build(context){
    return MaterialApp(

        home: Scaffold(
          body:
          addbenipage(),

          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title : Text('Add beni', textAlign: TextAlign.center,),
            leading: BackButton(),



          ),
          backgroundColor: Colors.white,
        )
    );
  }
}

class addbenipage extends StatefulWidget{
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addbeni();
  }
}

class addbeni extends State<addbenipage>{
  Widget build(context){
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: <Widget>[
            Text('Enter a wallet id to add a beni', style:TextStyle(fontStyle: FontStyle.italic),),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Wallet ID'
              ),
            ),
            RaisedButton(
              color: Colors.lightBlue,
              child: Text('Submit'),
              onPressed: (){},
            )
          ],
        ),
      ),

    );
  }
}
