import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infiveyears/animations/delayed_animation.dart';
import 'package:infiveyears/model/personal_det.dart';
import 'package:intl/intl.dart';

class InputDetails extends StatefulWidget {
  @override
  _InputDetailsState createState() => _InputDetailsState();
}

class _InputDetailsState extends State<InputDetails> {
  DateFormat df = new DateFormat("d / MMMM / y");
  Firestore firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String dob,
      _gender,
      _employment,
      _civilstat,
      _liquor,
      _name,
      _height,
      _weight;

  @override
  void initState() {
    dob = "Tap to enter dob";

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
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: "Name",
                        contentPadding: EdgeInsets.only(bottom: 10)),
                    onChanged: (value) => _name = value,
                  ),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Text(
                      dob,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  DropdownButton(
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
                  DropdownButton(
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
                  DropdownButton(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
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
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
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
                  DropdownButton(
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
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                          child: Text(
                            'Draft',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                          onPressed: draft,
                        ),
                        RaisedButton(
                          color: Colors.deepPurpleAccent,
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                          child: Text(
                            'Check',
                            style: TextStyle(
                              fontSize: 20.0,
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
      DocumentReference ref = await firestore.collection("queries").add(
          pd.toJson(_name, time, _civilstat, _gender, _employment,
              double.parse(_height), double.parse(_weight), _liquor));
    }
  }

  void draft(){
    
  }
}
