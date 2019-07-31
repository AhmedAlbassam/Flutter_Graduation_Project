import 'package:flutter/material.dart';
class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "New Task",
      theme: ThemeData(
          primaryColor: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Registration Form"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(text: "Become a Volunteer",),
            new Tab(text: "Rent a Booth"
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          MyApp(),MyApp1()
        ],
        controller: _tabController,),
    );
  }
}
//=============================================================================================================================================================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Registration form';
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      title: appTitle,
      home: Scaffold(
        body: MyCustomForm(),
      ),
    );
  }
}
// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'First name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Last name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Email'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Phone Number'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'have you volunteered before? If so, name the events'
            ),
            maxLines: 3,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 150,vertical: 50),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Registration form';
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      title: appTitle,
      home: Scaffold(
        body: BoothSeller(),
      ),
    );
  }
}
// Create a Form widget.
//=============================================================================================================================================================================
class BoothSeller extends StatefulWidget {
  @override
  MyCustomFormState2 createState() {
    return MyCustomFormState2();
  }
}
// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState2 extends State<BoothSeller> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'First name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Last name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Email'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Phone Number'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Number of booths'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Business activity'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field must not be empty';
              }
              return null;
            },
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 150,vertical: 50),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}