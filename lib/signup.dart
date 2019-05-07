import 'package:flutter/material.dart';
import 'package:boimala/home.dart';
import 'package:boimala/login.dart';

class Signup extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SignupPageState();
  }

}

class SignupPageState extends State<Signup>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Signup'),
        ),
      ),
    );
  }

}