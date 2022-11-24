import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String id;
  String name;
  String userId;
  String image;
  int numApplicants;
  String city;
  Timestamp applicationClosing;
  String description;
  String benefits;
  String requirements;
  String status;
  int jobScore;
  String workerId;
  List<String> applicants;

  Job(
    this.id,
    this.name,
    this.userId,
    this.image,
    this.numApplicants,
    this.city,
    this.applicationClosing,
    this.description,
    this.benefits,
    this.requirements,
    this.status,
    this.jobScore,
    this.workerId,
    this.applicants,
  );

  factory Job.fromFirestore(DocumentSnapshot doc) {
    return Job(
      doc.id,
      doc.data()!['name'],
      doc.data()!['user_id'],
      doc.data()!['image'],
      doc.data()!['num_applicants'],
      doc.data()!['city'],
      doc.data()!['application_closing'],
      doc.data()!['description'],
      doc.data()!['benefits'],
      doc.data()!['requirements'],
      doc.data()!['status'],
      doc.data()!['job_score'],
      doc.data()!['worker_id'],
      List.from(doc.data()!['applicants']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user_id': userId,
      'image': image,
      'num_applicants': numApplicants,
      'city': city,
      'application_closing': applicationClosing,
      'description': description,
      'benefits': benefits,
      'requirements': requirements,
      'status': status,
      'job_score': jobScore,
      'worker_id': workerId,
      'applicants': applicants,
    };
  }
}
