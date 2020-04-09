import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetails {
  String name;
  String age;
  Timestamp date_;
  DocumentReference reference;

  PersonalDetails.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        age = map['age'].toString(),
        date_ = map['date'];

  PersonalDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
