import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetails {
  String name;
  Timestamp dob;
  Timestamp date;
  String civilstatus;
  String gender;
  double height;
  double weight;
  String liquor;
  String employement;
  DocumentReference reference;

  PersonalDetails();

  PersonalDetails.fromMap(Map snapshot, {this.reference})
      : name = snapshot['name'],
        dob = snapshot['dob'],
        date = snapshot['date'],
        civilstatus = snapshot["civilstatus"],
        gender = snapshot["gender"],
        height = snapshot["height"],
        weight = snapshot["weight"],
        liquor = snapshot["liquor"],
        employement = snapshot["employment"];

  PersonalDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson(
    String name,
    Timestamp dob,
    String civilstatus,
    String gender,
    String employement,
    double height,
    double weight,
    String liquor,
  ) {
    return {
      "name": name,
      "dob": dob,
      "civilstatus": civilstatus,
      "employment": employement,
      "gender": gender,
      "height": height,
      "weight": weight,
      "liquor": liquor,
      "date": DateTime.now()
    };
  }
}
