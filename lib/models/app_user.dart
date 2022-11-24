import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;
  String name;
  String lastName;
  String phone;
  String city;
  String employerType;

  AppUser(
    this.id,
    this.name,
    this.lastName,
    this.phone,
    this.city,
    this.employerType,
  );

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    return AppUser(
      doc.id,
      doc.data()!['name'],
      doc.data()!['last_name'],
      doc.data()!['phone'],
      doc.data()!['city'],
      doc.data()!['employer_type'],
    );
  }

  factory AppUser.empty() {
    return AppUser(
      '',
      '',
      '',
      '',
      '',
      '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'last_name': lastName,
        'phone': phone,
        'city': city,
        'employer_type': employerType,
      };
}
