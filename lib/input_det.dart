import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'delayed_animation.dart';

class InputDetails extends StatefulWidget {
  @override
  State createState() => _StateID();
}

class _StateID extends State<InputDetails> {
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
        child: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            Expanded(
              child: Opacity(
                opacity: 0.5,
                child: Image(
                  color: Colors.deepPurple,
                  image: AssetImage("images/black.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            DelayedAnimation(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  "In order to predict problems,",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Traffolight"),
                ),
              ),
              delay: 500,
            ),
            DelayedAnimation(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  "We need to know little more about you.",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Traffolight"),
                  textAlign: TextAlign.center,
                ),
              ),
              delay: 500,
            ),
            SizedBox(
              height: 50,
            ),
            DelayedAnimation(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  "Is it okay?",
                  style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: "Traffolight"),
                ),
              ),
              delay: 2500,
            ),
          ]),
        ]),
      ),
    );
  }
}
