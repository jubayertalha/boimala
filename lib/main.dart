import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boimala/login.dart';
import 'package:boimala/home.dart';

//test comment

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Boimala',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home:Boimala(),
));

class Boimala extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return BoimalaState();
  }
}

class BoimalaState extends State<Boimala>{

  Timer _timer;
  int count = 4;
  String title = 'Boimala';

  isLogedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final bool logedIn = prefs.getBool('logedIn') ?? false;
    print('2: $logedIn');
    return logedIn;
  }

  setTimer(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool logedIn = prefs.getBool('logedIn') ?? false;
    print('2: $logedIn');

    _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer)=> setState((){

      if(count==5){
        timer.cancel();
        Navigator.of(context).pushReplacement(MaterialPageRoute<Null>(
            builder: (BuildContext context){
              print('1: $logedIn');
              if(logedIn){
                return Home();
              }else{
                return Login();
              }
            }
        ));
      }else{
        if(count.remainder(3)==1){
          title = 'Boimala.';
        }else if(count.remainder(3)==2){
          title = 'Boimala..';
        }else{
          title = 'Boimala...';
        }
        count++;
      }

    }));

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getTitle(BuildContext context){
    if(count == 4) setTimer(context);
    return title;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                    Icons.book,
                    size: 45.0,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    getTitle(context),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

}