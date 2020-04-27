import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infiveyears/edit_det.dart';
import 'package:infiveyears/input_det.dart';
import 'package:infiveyears/animations/fade_out_anim.dart';
import 'package:infiveyears/model/personal_det.dart';
import 'package:intl/intl.dart';
import 'package:infiveyears/drafts.dart';

class Home extends StatefulWidget {
  final String userId;

  Home({this.userId});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final Firestore firestore = Firestore.instance;
  BuildContext _context;
  Animation<double> animation;
  AnimationController animationController;
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

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    animation = Tween<double>(begin: 0, end: -20).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Material(
      child: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 142, 45, 226),
              Color.fromARGB(255, 74, 0, 224)
            ],
          )),
          child: Column(children: <Widget>[
            Container(
              width: 160,
              margin: EdgeInsets.only(top: 50, left: 0),
              child: OutlineButton(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                child: Row(children: <Widget>[
                  Text(
                    'Drafts',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.save,
                    color: Colors.white38,
                  ),
                ]),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white30, width: 3),
                onPressed: _showDraft,
              ),
            ),
            Expanded(
                child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  Navigator.of(context).push(FadeRouteBuilder(
                      page: InputDetails(
                    userId: widget.userId,
                  ))); //put the new page
                }
              },
              child: Column(
                children: <Widget>[
                  Expanded(child: _buildPages()),
                  Opacity(
                    opacity: 0.6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(0, animation.value),
                          child: Container(
                            child: Image(
                              image: AssetImage("images/swipe-up.png"),
                              width: 60,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Swipe up to add",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: "Traffolight"),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ])),
    );
  }

  Widget _buildPages() {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("users")
            .document(widget.userId)
            .collection("queries")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return SpinKitDoubleBounce(
              color: Colors.white,
              size: 90.0,
            );
          }

          return _buildQueryList(snapshot);
        });
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
    final double top = active ? 70 : 200;
    PersonalDetails _pdet = PersonalDetails.fromSnapshot(document);

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context)
              .push(FadeRouteBuilder(page: InputDetails())); //put the new page
        }
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
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
              ]),
          child: _content(_pdet, document)),
    );
  }

  void _delete(DocumentSnapshot documentSnapshot) {
    firestore
        .collection("users")
        .document(widget.userId)
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
                  showDialog(
                      context: _context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Delete!",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.black,
                                fontFamily: "Traffolight",
                                fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            "Do you want to delete?",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontFamily: "Traffolight"),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black54,
                                    fontFamily: "Traffolight"),
                              ),
                              onPressed: () {
                                _delete(documentSnapshot);
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black54,
                                    fontFamily: "Traffolight"),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
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
                onTap: () {
                  Navigator.of(context).push(FadeRouteBuilder(
                      page: EditDetails(
                    pdet: _pdet,
                    ref: documentSnapshot.documentID.toString(),
                  )));
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showDraft() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Draft()));
  }
}
