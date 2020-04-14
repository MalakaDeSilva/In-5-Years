import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infiveyears/home.dart';

import 'delayed_animation.dart';

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
              left: 125.0, right: 125.0, top: 15.0, bottom: 15.0),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        )
      ],
    ));
  }
}
