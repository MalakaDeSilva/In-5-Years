import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infiveyears/model/personal_det.dart';
import 'package:intl/intl.dart';

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
            if (!snapshot.hasData) {
              return SpinKitDoubleBounce(
                color: Colors.white,
                size: 90.0,
              );
            }

            return _buildQueryList(snapshot);
          }),
    );
  }

  Widget _buildQueryList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return PageView.builder(
      controller: _controller,
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, int currentIdx) {
        final DocumentSnapshot document = snapshot.data.documents[currentIdx];
        bool active = currentPage == currentIdx;

        return _buildPage(active, document);
      },
    );
  }

  Widget _buildPage(bool active, DocumentSnapshot document) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 150 : 300;
    PersonalDetails _pdet = PersonalDetails.fromSnapshot(document);
    print(document.reference.documentID);
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 100, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: _content(_pdet, document),
      ),
    );
  }

  void _delete(DocumentSnapshot documentSnapshot) {
    firestore
        .collection("queries")
        .document(documentSnapshot.reference.documentID)
        .delete();
  }

  Widget _content(PersonalDetails _pdet, DocumentSnapshot documentSnapshot) {
    DateFormat df = new DateFormat("d MMM y");

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 19),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.white,
              child: Text(
                _pdet.name,
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontFamily: "Traffolight"),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 19),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.white,
              child: Text(
                df.format(_pdet.date.toDate()),
                style: TextStyle(fontSize: 17.0, color: Colors.black54),
              ),
            ),
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.black,
        ),
        Expanded(
          child: Material(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "name - " + _pdet.name,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: "Traffolight"),
                ),
                Text(
                  "Date of Birth - " + df.format(_pdet.dob.toDate()),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: "Traffolight"),
                ),
                Text(
                  "Gender - " + _pdet.gender,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: "Traffolight"),
                ),
                Text(
                  "Civil status - " + _pdet.civilstatus,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: "Traffolight"),
                ),
                Text(
                  "Employment - " + _pdet.employement.toString(),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: "Traffolight"),
                )
              ],
            ),
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.black,
          height: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _delete(documentSnapshot);
                },
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20)),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 10, bottom: 10, right: 10, top: 5),
                    child: Icon(Icons.delete)),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20)),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 10, bottom: 10, right: 10, top: 5),
                    child: Icon(Icons.edit)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
