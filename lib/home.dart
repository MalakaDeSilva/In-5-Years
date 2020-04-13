import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Firestore firestore = Firestore.instance;

  PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  int currentPage = 0;

  @override
  void initState() {
    _controller.addListener(() {
      int next = _controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
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
      child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("queries").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');

            return _buildQueryList(snapshot);
          }),
    );
  }

  Widget _buildQueryList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return PageView.builder(
      controller: _controller,
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, int currentIdx) {
        bool active = currentPage == currentIdx;

        return _buildPage(active);
      },
    );
  }

  Widget _buildPage(bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 150 : 300;

    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]));
  }
}
