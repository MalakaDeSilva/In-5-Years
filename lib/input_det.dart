import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infiveyears/animations/delayed_animation.dart';
import 'package:intl/intl.dart';

class InputDetails extends StatefulWidget {
  @override
  _InputDetailsState createState() => _InputDetailsState();
}

class _InputDetailsState extends State<InputDetails> {
  DateFormat df = new DateFormat("d / MMMM / y");
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String dob, _gender, _employment, _civilstat, _liquor;

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
              color: Colors.green,
            ),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white54),
                        hintText: "Name",
                        contentPadding: EdgeInsets.only(bottom: 10)),
                  ),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Text(
                      dob,
                      style: TextStyle(
                        color: dob == "Tap to enter dob"
                            ? Colors.white70
                            : Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  DropdownButton(
                    hint: Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ), // Not necessary for Option 1
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
                            color:
                                _gender == null ? Colors.black : Colors.white,
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
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ), // Not necessary for Option 1
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
                            color: _employment == null
                                ? Colors.black
                                : Colors.white,
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
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ), // Not necessary for Option 1
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
                            color: _employment == null
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white54),
                              hintText: "Height",
                              contentPadding: EdgeInsets.only(bottom: 10)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white54),
                              hintText: "Weight",
                              contentPadding: EdgeInsets.only(bottom: 10)),
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  DropdownButton(
                    hint: Text(
                      'Use Liquor',
                      style: TextStyle(
                        color: Colors.white70,
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
                            color:
                                _liquor == null ? Colors.black : Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
