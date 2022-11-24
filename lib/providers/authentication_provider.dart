import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/services/authentication.dart';
import 'package:oficiospe_app_employee/services/database.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = authentication.firebasAuth;
  final GoogleSignIn _googleSignIn = authentication.googleSignIn;
  bool _loginPage = false;
  int _welcomePageIndex = 0;
  int _lastPageIndex = -1;

  bool _loading = true;

  int get lastPageIndex => _lastPageIndex;

  set lastPageIndex(int index) {
    _lastPageIndex = index;
    notifyListeners();
  }

  int get welcomePageIndex => _welcomePageIndex;

  set welcomePageIndex(int index) {
    _welcomePageIndex = index;
    notifyListeners();
  }

  Stream<User?> get authState => _firebaseAuth.idTokenChanges();

  User? get user => _firebaseAuth.currentUser;

  bool get isLoginPage => _loginPage;

  set isLoginPage(bool state) {
    _loginPage = state;
    notifyListeners();
  }

  bool get isLoading => _loading;

  Future<void> _addUserToDB(
      String userId,
      String firstName,
      String lastName,
      String phone,
      String city,
      String profession,
      String gender,
      String knowledges,
      int age) async {
    await database.addWorker(
      userId,
      firstName,
      lastName,
      phone,
      city,
      profession,
      gender,
      knowledges,
      age,
    );
  }

  Future<void> signUp(
      String email, String password, String firstName, String phone) async {
    try {
      _loading = true;
      notifyListeners();
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();

      await _addUserToDB(
        userCredential.user!.uid,
        firstName,
        '',
        phone,
        '',
        '',
        '',
        '',
        0,
      );

      _loading = false;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      _loading = true;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _loading = false;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _loading = true;
      notifyListeners();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _addUserToDB(
          userCredential.user!.uid,
          userCredential.additionalUserInfo!.profile!['given_name'],
          '',
          '',
          '',
          '',
          '',
          '',
          0,
        );
      }
      _loading = false;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  Future<void> signInAnonymously() async {
    try {
      _loading = true;
      notifyListeners();
      await _firebaseAuth.signInAnonymously();
      _loading = false;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception {
      rethrow;
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    try {
      _loading = true;
      notifyListeners();

      if (_firebaseAuth.currentUser?.email != null) {
        String email = _firebaseAuth.currentUser?.email ?? "";
        AuthCredential authCredential = EmailAuthProvider.credential(
            email: email, password: currentPassword);
        await _firebaseAuth.currentUser!
            .reauthenticateWithCredential(authCredential);
        await _firebaseAuth.currentUser!.updatePassword(newPassword);
      }
      _loading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOutEmail() async {
    try {
      _loading = true;
      notifyListeners();
      await _firebaseAuth.signOut();
      _loading = false;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  Future<void> signOutGoogle() async {
    try {
      _loading = true;
      notifyListeners();
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      _loading = false;
      notifyListeners();
    } on Exception {
      rethrow;
    }
  }
}
