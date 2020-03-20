import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infiveyears/delayed_animation.dart';
import 'package:shadow/shadow.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 25,178,238),
                    Color.fromARGB(255, 21,236,229)
                  ],
                )),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                DelayedAnimation(
                  child: AvatarGlow(
                    endRadius: 90,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white24,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 2),
                    startDelay: Duration(seconds: 1),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Image(
                            color: Color.fromARGB(255, 90, 93, 163),
                            image: AssetImage("images/black.png"),
                          ),
                          radius: 60.0,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 13.0,
                              color: Colors.black.withOpacity(.5),
                              offset: Offset(0, 7.0),
                            ),
                          ],
                          shape: BoxShape.circle,
                          //border: Border.all(),
                          color: Color(0xFF8185E2),
                        ),
                      ),
                    ),
                  ),
                  delay: delayedAmount + 500,
                ),
                SizedBox(
                  height: 20.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "Hi There!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.0,
                      color: color,
                      fontFamily: 'Traffolight',
                    ),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(
                  height: 80.0,
                ),
                DelayedAnimation(
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Do you want to know",
                        style: TextStyle(fontSize: 20.0, color: color),
                      ),
                    ),
                  ),
                  delay: delayedAmount + 2000,
                ),
                DelayedAnimation(
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "The things you could be facing",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  delay: delayedAmount + 2500,
                ),
                DelayedAnimation(
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      child: Text(
                        "In 5 Years!",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  delay: delayedAmount + 3000,
                ),
                Expanded(
                  child: Container(
                    child: GestureDetector(
                      onVerticalDragDown: _onVerticalDragDown,
                    ),
                  ),
                ),
                DelayedAnimation(
                  child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 50.0),
                          child: _animatedButtonUI),
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),
              ],
            ),
          )),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20.0,
                  color: Colors.black.withOpacity(.5),
                  offset: Offset(0, 7.0),
                  spreadRadius: 5),
            ]),
        child: Center(
          child: Text(
            'Yes!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void  _onVerticalDragDown(DragDownDetails details){
    exit(0);
  }
}
