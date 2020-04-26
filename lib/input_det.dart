import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infiveyears/animations/delayed_animation.dart';
import 'package:infiveyears/drafts.dart';
import 'package:infiveyears/model/personal_det.dart';
import 'package:intl/intl.dart';

class InputDetails extends StatefulWidget {
  final String userId;

  InputDetails({this.userId});

  @override
  _InputDetailsState createState() => _InputDetailsState();
}

class _InputDetailsState extends State<InputDetails> {
  DateFormat df = new DateFormat("d / MMMM / y");
  Firestore firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String _gender, _employment, _civilstat, _liquor, _name, _height, _weight;
  String dob = "Date of birth";

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dob = df.format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
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
        child: DelayedAnimation(
          delay: 500,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            padding: EdgeInsets.only(left: 5, right: 5, top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Name",
                          contentPadding: EdgeInsets.only(bottom: 10)),
                      onChanged: (value) => _name = value,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Text(
                        dob,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: DropdownButton(
                      hint: Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: _gender,
                      onChanged: (newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      items: ["Male", "Female"].map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: DropdownButton(
                      hint: Text(
                        'Employment',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: _employment,
                      onChanged: (newValue) {
                        setState(() {
                          _employment = newValue;
                        });
                      },
                      items: ["Employed", "Un-employed"].map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: DropdownButton(
                      hint: Text(
                        'Civil status',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: _civilstat,
                      onChanged: (newValue) {
                        setState(() {
                          _civilstat = newValue;
                        });
                      },
                      items: ["Married", "Unmarried"].map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.25,
                          child: TextFormField(
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: "Height",
                                contentPadding: EdgeInsets.only(bottom: 10)),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _height = value,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.15,
                          child: TextFormField(
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: "Weight",
                                contentPadding: EdgeInsets.only(bottom: 10)),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _weight = value,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: DropdownButton(
                      hint: Text(
                        'Use Liquor',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: _liquor,
                      onChanged: (newValue) {
                        setState(() {
                          _liquor = newValue;
                        });
                      },
                      items: ["Yes", "No"].map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 35, right: 35),
                          child: Text(
                            'Draft',
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent, width: 2),
                          onPressed: draft,
                        ),
                        RaisedButton(
                          color: Colors.deepPurpleAccent,
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 30, right: 30),
                          child: Text(
                            'Check',
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: create,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void create() async {
    if (_formKey.currentState.validate()) {
      PersonalDetails pd = new PersonalDetails();
      Timestamp time = Timestamp.fromDate(selectedDate);
      await firestore
          .collection("users")
          .document(widget.userId)
          .collection("queries")
          .add(pd.toJson(
              _name,
              time,
              _civilstat,
              _gender,
              _employment,
              double.parse(_height),
              double.parse(_weight),
              _liquor)); //Returns the DocumentReference
    }
  }

  showAlertDialog(BuildContext context, String message, String heading,
      String buttonAcceptTitle) {
    // set up the buttons

    Widget continueButton = FlatButton(
      child: Text(buttonAcceptTitle),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(heading),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void draft() {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Draft()));
    createTodos();
    showAlertDialog(context, 'Record Saved in the Draft?', "$_name", "Ok");
  }

  createTodos() {
    DocumentReference documentReference =
        Firestore.instance.collection("drafts").document(_name);

    //Map
    Map<String, String> todos = {"Name_": _name};

    documentReference.setData(todos).whenComplete(() {
      print("$_name created");
    });
  }
}
