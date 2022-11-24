import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oficiospe_app_employee/models/app_user.dart';
import 'package:oficiospe_app_employee/models/job.dart';
import 'package:oficiospe_app_employee/models/worker.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addJob(
      String name,
      String userId,
      String image,
      int numApplicants,
      String city,
      Timestamp applicationClosing,
      String description,
      String benefits,
      String requirements,
      String status) async {
    await _firestore.collection('jobs').doc().set({
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
    });
  }

  Future<List<Job>> getJobs() async {
    var jobsSnap = await _firestore.collection('jobs').get();

    var jobs = <Job>[];
    for (var doc in jobsSnap.docs) {
      jobs.add(Job.fromFirestore(doc));
    }
    return jobs;
  }

  Future<List<Job>> getFavoriteJobs(List<String> idJobs) async {
    try {
      List<Job> jobs = [];
      for (var i = 0; i < idJobs.length; i++) {
        DocumentSnapshot workerDoc =
            await _firestore.collection('jobs').doc(idJobs[i]).get();
        jobs.add(Job.fromFirestore(workerDoc));
      }
      return jobs;
    } on Exception {
      rethrow;
    }
  }

  Future<List<Job>> getAppliedJobs(List<String> idJobs) async {
    try {
      List<Job> jobs = [];
      for (var i = 0; i < idJobs.length; i++) {
        DocumentSnapshot workerDoc =
            await _firestore.collection('jobs').doc(idJobs[i]).get();
        jobs.add(Job.fromFirestore(workerDoc));
      }
      return jobs;
    } on Exception {
      rethrow;
    }
  }

  Future<void> addFavoriteJob(String workerId, String jobId) async {
    try {
      WriteBatch batch = _firestore.batch();
      batch.update(
        _firestore.collection('workers').doc(workerId),
        {
          'favorite_jobs': FieldValue.arrayUnion([jobId])
        },
      );
      await batch.commit();
    } on Exception {
      rethrow;
    }
  }

  Future<void> removeFavoriteJob(String workerId, String jobId) async {
    try {
      WriteBatch batch = _firestore.batch();
      batch.update(
        _firestore.collection('workers').doc(workerId),
        {
          'favorite_jobs': FieldValue.arrayRemove([jobId])
        },
      );
      await batch.commit();
    } on Exception {
      rethrow;
    }
  }

  Future<void> updateJob(String jobId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('jobs').doc(jobId).update(newData);
    } on Exception {
      rethrow;
    }
  }

  Future<AppUser> getUser(String userId) async {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        AppUser user = AppUser.fromFirestore(userDoc);
        return user;
      } on Exception {
        rethrow;
      }
    }

  Future<void> addWorker(
      String userId,
      String firstName,
      String lastName,
      String phone,
      String city,
      String profession,
      String gender,
      String knowledges,
      int age) async {
    await _firestore.collection('workers').doc(userId).set({
      'name': firstName,
      'phone': phone,
      'last_name': lastName,
      'city': city,
      'profession': profession,
      'gender': gender,
      'knowledges': knowledges,
      'age': age,
      'enrollment_date': Timestamp.now(),
      'favorite_jobs': [],
    });
  }

  Future<void> updateWorker(
      String workerId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('workers').doc(workerId).update(newData);
    } on Exception {
      rethrow;
    }
  }

  Future<Worker> getworker(String workerId) async {
    try {
      DocumentSnapshot workerDoc =
          await _firestore.collection('workers').doc(workerId).get();
      Worker worker = Worker.fromFirestore(workerDoc);
      return worker;
    } on Exception {
      rethrow;
    }
  }

  Future<List<Worker>> getWorkers(List<String> workerIds) async {
    try {
      List<Worker> workers = [];
      for (var i = 0; i < workerIds.length; i++) {
        DocumentSnapshot workerDoc =
            await _firestore.collection('workers').doc(workerIds[i]).get();
        workers.add(Worker.fromFirestore(workerDoc));
      }
      return workers;
    } on Exception {
      rethrow;
    }
  }

  Future<void> postulate(String workerId, String jobId) async {
    try {
      WriteBatch batch = _firestore.batch();
      batch.update(
        _firestore.collection('workers').doc(workerId),
        {
          'applied_jobs': FieldValue.arrayUnion([jobId])
        },
      );
      batch.update(
        _firestore.collection('jobs').doc(jobId),
        {
          'applicants': FieldValue.arrayUnion([workerId])
        },
      );
      await batch.commit();
    } on Exception {
      rethrow;
    }
  }
}

final Database database = Database();
