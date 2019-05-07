import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:boimala/signup.dart';
import 'package:boimala/home.dart';
import 'package:boimala/api.dart';

class Login extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends State<Login>{

  static final _formKey = GlobalKey<FormState>();

  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  static final emailController = TextEditingController();
  static final passController = TextEditingController();

  final emailTextField = TextFormField(
    validator: (value){
      if(value.isEmpty){
        return 'Please Enter Email';
      }
    },
    controller: emailController,
    obscureText: false,
    style: style,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        icon: Icon(Icons.email),
        labelText: 'Email'
    ),
  );

  final passTextField = TextFormField(
    validator: (value){
      if(value.isEmpty){
        return 'Please Enter Password';
      }
    },
    controller: passController,
    obscureText: true,
    style: style,
    maxLines: 1,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        icon: Icon(Icons.pie_chart),
        labelText: 'Passwoid'
    ),
  );

  getLoginButton(BuildContext context){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            ProgressDialog dialog = new ProgressDialog(context, ProgressDialogType.Normal);
            dialog.setMessage('Login...');
            dialog.show();
            String response = await Api().login(emailController.text, passController.text);
            dialog.hide();
            Map data = json.decode(response);
            print(data['code']);
            if(data['code']==0){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text(
                        data['msg'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0
                        ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text(
                            "OK",
                            style: TextStyle(
                              fontSize: 18.0
                            ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }else{
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('logedIn', true);
              prefs.setString('email', emailController.text);
              Navigator.of(context).pushReplacement(MaterialPageRoute<Null>(
                  builder:(context){
                    return Home();
                  }
              ));
            }
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.black
                    ),
                  ),
                  SizedBox(height: 24.0,),
                  emailTextField,
                  SizedBox(height: 16.0,),
                  passTextField,
                  SizedBox(height: 24.0,),
                  getLoginButton(context),
                  SizedBox(height: 44.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (context){
                            return Signup();
                          }
                      ));
                    },
                    child: Text(
                      "Don't have an account? Signup Now!",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff01A0C7),
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}