import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDetails extends StatefulWidget {
  @override
  _InputDetailsState createState() => _InputDetailsState();
}

class _InputDetailsState extends State<InputDetails> {
  DateFormat df = new DateFormat("d / MMMM / y");
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String dob, _gender, _employment;

  @override
  void initState() {
    dob = "Tap to enter dob";
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                items: ["Married", "Unmarried"].map((location) {
                  return DropdownMenuItem(
                    child: new Text(
                      location,
                      style: TextStyle(
                        color: _employment == null ? Colors.black : Colors.white,
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
    );
  }
}
