import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infiveyears/home.dart';
import 'package:infiveyears/model/personal_det.dart';
import 'package:infiveyears/services/bmi_calc.dart';

class ProblemsPage extends StatefulWidget {
  final PersonalDetails pdet;
  final String userId;

  ProblemsPage({this.pdet, this.userId});

  @override
  _ProblemsState createState() => _ProblemsState();
}

class _ProblemsState extends State<ProblemsPage> {
  CollectionReference problem = Firestore.instance.collection("problmes");
  DocumentReference docRef;
  BMICalculator bmiCalculator = new BMICalculator();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
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
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  bottom: MediaQuery.of(context).size.height * 0.15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: FutureBuilder(
                  future: getList(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(itemBuilder: (context, index) {
                        try {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepPurple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              snapshot.data[index],
                              style: TextStyle(fontSize: 25),
                            ),
                          );
                        } catch (e) {
                          return null;
                        }
                      });
                    } else {
                      return SpinKitDoubleBounce(
                        color: Colors.deepPurple,
                        size: 90.0,
                      );
                    }
                  }),
            )),
      ),
    );
  }

  Future<List<String>> getList() async {
    PersonalDetails pd = widget.pdet;
    List<String> problemsList = new List();

    if (pd.liquor == "Yes") {
      docRef = problem.document("liquor_y");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    if (pd.civilstatus == "Married") {
      docRef = problem.document("married_y");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    if (pd.civilstatus == "Unmarried") {
      docRef = problem.document("married_n");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    if (pd.employement == "Employed") {
      docRef = problem.document("employed_y");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    if (pd.employement == "Un-employed") {
      docRef = problem.document("employed_n");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    if (getAge(pd.dob) > 30) {
      docRef = problem.document("age_30");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    if (getAge(pd.dob) < 30 && getAge(pd.dob) > 18) {
      docRef = problem.document("age_18");
      await docRef.get().then((data) {
        if (data.exists) {
          problemsList.add(data.data['problem'].toString());
        }
      });
    }

    problemsList.add(bmiCalculator.getStatus(pd.weight, pd.height));

    return problemsList;
  }

  int getAge(Timestamp _date) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - _date.toDate().year;
    int month1 = currentDate.month;
    int month2 = _date.toDate().month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = _date.toDate().day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  Future<bool> _onWillPop() async {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
              userId: widget.userId,
            )));
  }
}
