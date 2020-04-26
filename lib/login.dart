import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infiveyears/home.dart';

import './animations/delayed_animation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:infiveyears/services/auth_services.dart';

var authHandler = new Auth();

String _emailId;
String _password;
final _emailIdController = TextEditingController(text: '');
final _passwordController = TextEditingController(text: '');

class Login extends StatefulWidget {
  @override
  State createState() => _StateID();
}

class _StateID extends State<Login> {
  int selected;
  bool passwordVisible;

  @override
  void initState() {
    selected = 0;
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 142, 45, 226),
              Color.fromARGB(255, 74, 0, 224)
            ],
          )),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/thinking.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: DelayedAnimation(
              delay: 750,
              child: _login(),
            ),
          )),
    );
  }

  Widget _login() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFFFFFFFF).withOpacity(0.8),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (value) {
                    _emailId = value;
                  },
                  controller: _emailIdController,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Username/Email",
                    contentPadding: EdgeInsets.only(left: 30.0, top: 10.0),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                TextFormField(
                  onSaved: (value) {
                    _emailId = value;
                  },
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    contentPadding: EdgeInsets.only(left: 30.0, top: 10.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          color: Colors.white,
          padding: EdgeInsets.only(
              left: 140.0, right: 140.0, top: 15.0, bottom: 15.0),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          onPressed: () {
            authHandler
                .handleSignInEmail(
                    _emailIdController.text, _passwordController.text)
                .then((FirebaseUser user) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Home(
                            userId: user.uid,
                          )));
            }).catchError((e) => print(e));
          },
        ),
        new Container(
          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 5.0),
          child: new RaisedButton(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
              color: Colors.white,
              onPressed: () async {
                bool res = await authHandler.loginWithGoogle();

                print(authHandler.getUser());
                if (!res) {
                  print("error logging in with google");
                } else {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Home(userId: authHandler.getUser().uid,)));
                }
              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'images/google.png',
                    height: 48.0,
                  ),
                  new Container(
                      padding: EdgeInsets.only(
                          left: 65.0, right: 90.0, top: 15.0, bottom: 15.0),
                      child: new Text(
                        "Sign in with Google",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ],
              )),
        ),
        new Container(
          margin: EdgeInsets.fromLTRB(30.0, 7.0, 30.0, 5.0),
          child: new RaisedButton(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
              color: Colors.white,
              onPressed: () async {
                bool res = await authHandler.facebookSignedIn();

                if (!res) {
                  print("error logging in with facebook");
                } else {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Home(userId: authHandler.getUser().uid,)));
                }
              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'images/facebook.png',
                    height: 48.0,
                  ),
                  new Container(
                      margin: EdgeInsets.only(
                          left: 0.0, right: 35.0, top: 0.0, bottom: 0.0),
                      padding: EdgeInsets.only(
                          left: 65.0, right: 40.0, top: 15.0, bottom: 15.0),
                      child: Center(
                          child: Text(
                        "Sign in with Facebook",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))),
                ],
              )),
        ),
      ],
    ));
  }
}
