import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  String id;
  String name;
  String lastName;
  String profession;
  int age;
  String gender;
  String city;
  String knowledges;
  Timestamp enrollmentDate;
  String phone;
  List<String> favoriteJobs;
  List<String> appliedJobs;

  Worker(
      this.id,
      this.name,
      this.lastName,
      this.profession,
      this.age,
      this.gender,
      this.city,
      this.knowledges,
      this.enrollmentDate,
      this.phone,
      this.favoriteJobs,
      this.appliedJobs);

  factory Worker.fromFirestore(DocumentSnapshot doc) {
    return Worker(
      doc.id,
      doc.data()!['name'],
      doc.data()!['last_name'],
      doc.data()!['profession'],
      doc.data()!['age'],
      doc.data()!['gender'],
      doc.data()!['city'],
      doc.data()!['knowledges'],
      doc.data()!['enrollment_date'],
      doc.data()!['phone'],
      List.from(doc.data()!['favorite_jobs']),
      List.from(doc.data()!['applied_jobs']),
    );
  }

  factory Worker.empty() {
    return Worker(
      '',
      '',
      '',
      '',
      0,
      '',
      '',
      '',
      Timestamp.now(),
      '',
      [],
      [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastName,
      'profession': profession,
      'age': age,
      'gender': gender,
      'city': city,
      'knowledges': knowledges,
      'enrollment_date': enrollmentDate,
      'phone': phone,
      'favorite_jobs': favoriteJobs,
      'applied_jobs': appliedJobs,
    };
  }
}
