import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boimala/login.dart';

class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('logedIn', false);
                Navigator.of(context).pushReplacement(MaterialPageRoute<Null>(
                    builder: (context){
                      return Login();
                    }
                ));
              },
            child: Text('Logout'),
            elevation: 4.0,
            splashColor: Colors.red,
          ),
        ),
      ),
    );
  }

}