import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infiveyears/animations/delayed_animation.dart';
import 'package:infiveyears/login.dart';
import 'package:rect_getter/rect_getter.dart';

import './animations/fade_out_anim.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  final Duration animationDuration = Duration(milliseconds: 500);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;

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
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                DelayedAnimation(
                  child: AvatarGlow(
                    endRadius: 90,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white,
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
                            color: Colors.deepPurple,
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
                          color: Colors.black,
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
                      fontFamily: 'M PLUS Rounded 1c',
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
                        "Would you like to know",
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
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: RectGetter(
                      key: rectGetterKey,
                      child: RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 125.0, right: 125.0, top: 15.0, bottom: 15.0),
                        child: Text(
                          'Yes!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: _onTap,
                      ),
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),
              ],
            ),
            _ripple(),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      rect = RectGetter.getRectFromKey(rectGetterKey);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: Login()))
        .then((_) => setState(() => rect = null));
  }

  void _onVerticalDragDown(DragDownDetails details) {}

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurpleAccent,
        ),
      ),
      duration: animationDuration,
    );
  }
}
