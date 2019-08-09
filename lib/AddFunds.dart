import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
//import 'package:intl/intl.dart';

void main() => runApp(new Funds());

class Funds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      title: 'Add balance demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body:
        AddFundsPage(),

        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title : Text('Add Funds', textAlign: TextAlign.center,),
          leading: BackButton(),



        ),
        backgroundColor: Colors.white,
      ),

    );
  }
}
class AddFundsPage extends StatefulWidget {
  AddFundsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddFundsPageState createState() => new _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var txt = TextEditingController();
  DateTime date = new DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate:date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget child) {
          return FittedBox(
              child: Theme(
                  child: child,
                  data: ThemeData(
                    primaryColor: Colors.blue[300],

                  )));
        });
    setState((){
      date = picked;
      txt.text = date.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(

                      hintText: 'Enter your first name',
                      labelText: 'First Name',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(

                      hintText: 'Enter your last name',
                      labelText: 'Last Name',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Card Number',
                      labelText: 'Card Number',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15)
                      , WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),

                  TextFormField(
                    controller: txt,
                    decoration: InputDecoration(
                        hintText:'Card Expiry Date',
                        labelText:'Card Expiry Date',

                        suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              selectDate(context);
                            }

                        )),
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter CVV number',
                      labelText: 'CVV',

                    ) ,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  )
                  ,
                  new Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: null,
                        // API ????
                      )),
                ],
              ))),
    );
  }
}