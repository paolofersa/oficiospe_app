import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth get firebasAuth => _firebaseAuth;
  GoogleSignIn get googleSignIn => _googleSignIn;
}

final authentication = Authentication();
