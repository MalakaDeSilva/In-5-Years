import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infiveyears/model/personal_det.dart';
import 'package:intl/intl.dart';

import 'animations/delayed_animation.dart';

class EditDetails extends StatefulWidget {
  final PersonalDetails pdet;
  final String ref;
  final String userId;

  EditDetails({this.pdet, this.ref, this.userId});

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  DateFormat df = new DateFormat("d / MMMM / y");
  DateTime selectedDate = DateTime.now();
  Firestore firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String _gender, _employment, _civilstat, _liquor, _name, _height, _weight;
  String dob = "Date of birth";

  @override
  void initState() {
    _name = widget.pdet.name;
    dob = df.format(widget.pdet.date.toDate());
    _height = widget.pdet.height.toString();
    _weight = widget.pdet.weight.toString();
    _civilstat = widget.pdet.civilstatus;
    _liquor = widget.pdet.liquor;
    _gender = widget.pdet.gender;
    _employment = widget.pdet.employement;

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
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a name";
                        }

                        return null;
                      },
                      initialValue: _name,
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your height";
                              }

                              return null;
                            },
                            initialValue: _height,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 30,
                          margin: EdgeInsets.only(bottom: 10, right: 20),
                          color: Colors.deepPurpleAccent,
                          child: Text(""),
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter yout weight";
                              }

                              return null;
                            },
                            initialValue: _weight,
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
                            'Cancel',
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        RaisedButton(
                          color: Colors.deepPurpleAccent,
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 45, right: 45),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: update,
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

  void update() {
    PersonalDetails pd = new PersonalDetails();
    Timestamp time = Timestamp.fromDate(selectedDate);

    pd.setValues(_name, time, _civilstat, _gender, double.parse(_height),
        double.parse(_weight), _liquor, _employment);

    firestore
        .collection("users")
        .document(widget.userId)
        .collection("queries")
        .document(widget.ref)
        .updateData(pd.toJson());

    Navigator.of(context).pop();
  }
}
