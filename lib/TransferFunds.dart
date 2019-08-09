import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new Transfer());

class Transfer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Add balance demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransferPage(title: 'Transfer',),
    );
  }
}
class TransferPage extends StatefulWidget {
  TransferPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TransferPageState createState() => new _TransferPageState();
}


class _TransferPageState extends State<TransferPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title, textAlign: TextAlign.center,),
        leading: BackButton(),
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
                    decoration: InputDecoration(

                      hintText: 'Transfer Amount',
                      labelText: 'Amount',
                    )
                    ,
                    keyboardType: TextInputType.number ,
                  )
                  ,


                  new TextFormField(
                    decoration: const InputDecoration(

                      hintText: 'User Email',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: null,        // API HERE ????
                      )),
                ],
              ))),
    );
  }
}