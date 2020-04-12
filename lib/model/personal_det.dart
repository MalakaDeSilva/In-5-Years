import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetails {
  String name;
  String age;
  Timestamp date;
  DocumentReference reference;

  PersonalDetails.fromMap(Map snapshot, {this.reference})
      : name = snapshot['name'],
        age = snapshot['age'].toString(),
        date = snapshot['date'];

  PersonalDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
