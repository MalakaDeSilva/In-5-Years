import 'package:flutter/material.dart';

class InputDetails extends StatefulWidget {
  @override
  State createState() => _StateID();
}

class _StateID extends State<InputDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
