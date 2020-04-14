import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetails {
  String name;
  Timestamp dob;
  Timestamp date;
  String civilstatus;
  String gender;
  bool employement;
  DocumentReference reference;

  PersonalDetails.fromMap(Map snapshot, {this.reference})
      : name = snapshot['name'],
        dob = snapshot['dob'],
        date = snapshot['date'],
        civilstatus = snapshot["civilstatus"],
        gender = snapshot["gender"],
        employement = snapshot["employment"];

  PersonalDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
