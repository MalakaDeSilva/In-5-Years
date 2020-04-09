import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.8,);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 142, 45, 226),
          Color.fromARGB(255, 74, 0, 224)
        ],
      )),
      child: PageView(controller: _controller, children: getWidgets(),),
    );
  }

  List<Widget> getWidgets() {
    List<Widget> _list = [
      Container(
        margin: EdgeInsets.only(top: 50, bottom: 50, right: 20),
        color: Colors.red,
      ),
      Container(
        margin: EdgeInsets.only(top: 50, bottom: 50, right: 20),
        color: Colors.green,
      ),
      Container(
        margin: EdgeInsets.only(top: 50, bottom: 50, right: 20),
        color: Colors.blue,
      )
    ];

    return _list;
  }
}
