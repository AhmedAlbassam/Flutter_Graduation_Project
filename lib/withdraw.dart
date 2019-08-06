import 'package:flutter/material.dart';

class displaywithdraw extends StatelessWidget{
  Widget build(context){
    return MaterialApp(

        home: Scaffold(
          body:
          WithdrawPage(),

          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title : Text('Withdraw', textAlign: TextAlign.center,),
            leading: BackButton(),



          ),
          backgroundColor: Colors.white,
        )
    );
  }
}

class WithdrawPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return withdraw();
  }
}




class withdraw extends State<WithdrawPage>{
  Widget build(context){
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: <Widget>[
            amount(),
            creditCardInfo(),
            submitbutt(),
          ],
        ),
      ),

    );
  }
  Widget amount(){
    return TextFormField(
      keyboardType: TextInputType.number ,
      decoration: InputDecoration(
        labelText: 'Enter the amount',
        hintText: '100',
      ),
    );
  }
  Widget creditCardInfo(){
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              labelText: 'name on card'
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: 'Card number'
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: 'CVV'
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: 'Expired date'
          ),
        ),
      ],
    );
  }
  Widget submitbutt(){
    return RaisedButton(
      color: Colors.lightBlue,
      child: Text('Submit'),
      onPressed: (){},
    );
  }
}