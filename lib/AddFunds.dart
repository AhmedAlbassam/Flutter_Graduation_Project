import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Funds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      title: 'Add balance demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddFundsPage(title: 'Add balance',),

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


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: new Text(widget.title, textAlign: TextAlign.center,),
    leading: IconButton(icon:Icon(Icons.arrow_back),
    onPressed:() => Navigator.pop(context, false),
    ),
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
                    decoration: InputDecoration(
                        hintText:'Card Expiry Date',
                        labelText:'Card Expiry Date',
                        ),
                    keyboardType: TextInputType.datetime
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
          new TextFormField(
            decoration: InputDecoration(

              hintText: 'Enter Amount added to balance',
              labelText: 'Amount',
            )
            ,
            keyboardType: TextInputType.number ,
          ),
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