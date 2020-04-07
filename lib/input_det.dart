
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'delayed_animation.dart';

class InputDetails extends StatefulWidget {
  @override
  State createState() => _StateID();
}

class _StateID extends State<InputDetails> {
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
    final List<Widget> _body = [
      _message(),
      _detailsForm(),
    ];

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
          child: Stack(
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Opacity(
                    opacity: 0.5,
                    child: Image(
                      image: AssetImage("images/thinking.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              ]),
              Container(
                width: 900,
                height: 900,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
              AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      child: child,
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                    );
                  },
                  duration: Duration(milliseconds: 900),
                  child: _body[selected]),
            ],
          )),
    );
  }

  Widget _message() {
    return Stack(children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        DelayedAnimation(
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "Before we proceed further,",
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: "Traffolight"),
            ),
          ),
          delay: 1000,
        ),
        DelayedAnimation(
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "We would like to know little more about yourself.",
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: "Traffolight"),
              textAlign: TextAlign.center,
            ),
          ),
          delay: 1000,
        ),
        SizedBox(
          height: 50,
        ),
        DelayedAnimation(
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            margin: EdgeInsets.only(bottom: 30.0),
            child: Text(
              "Is it okay ?",
              style: TextStyle(
                  color: Colors.white, fontSize: 35, fontFamily: "Traffolight"),
            ),
          ),
          delay: 3500,
        ),
        DelayedAnimation(
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: 125.0, right: 125.0, top: 15.0, bottom: 15.0),
            child: Text(
              'Okay!',
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
              setState(() {
                selected = 1;
              });
            },
          ),
          delay: 3500,
        ),
        DelayedAnimation(
          child: Opacity(
            opacity: 0.2,
            child: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Divider(
                color: Colors.white,
                thickness: 2,
                indent: 30.0,
                endIndent: 30.0,
              ),
            ),
          ),
          delay: 3500,
        ),
        DelayedAnimation(
          child: RaisedButton(
            color: Color(0x00000000),
            padding: EdgeInsets.only(
                left: 95.0, right: 95.0, top: 15.0, bottom: 15.0),
            child: Text(
              'No, It is not!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputDetails()));
            },
          ),
          delay: 3500,
        ),
      ]),
    ]);
  }

  Widget _detailsForm() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            color: Color(0xFFFFFFFF).withOpacity(0.67),
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
            setState(() {
              selected = 1;
            });
          },
        )
      ],
    ));
  }
}
