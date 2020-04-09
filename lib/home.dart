import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  int currentPage = 0;

  @override
  void initState() {
    int next = _controller.page.round();

    if (currentPage != next) {
      setState(() {
        currentPage = next;
      });
    }
    super.initState();
  }

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
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, int currentIdx) {
          bool active = currentPage == currentIdx;
          return _buildPage(active);
        },
      ),
    );
  }

  Widget _buildPageList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('reviews').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildPage(context, data)).toList(),
    );
  }

  Widget _buildPage(bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]));
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
