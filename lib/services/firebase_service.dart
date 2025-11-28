import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  // Singleton
  FirebaseService._privateConstructor();
  static final FirebaseService instance = FirebaseService._privateConstructor();

  // Firebase instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => auth.currentUser;

  // AUTH FUNCTIONS
  Future<User?> signUp(String email, String password) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> login(String email, String password) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  // FIRESTORE FUNCTIONS
  Future<void> saveUserData(String uid, Map<String, dynamic> data) async {
    return await db.collection("users").doc(uid).set(data, SetOptions(merge: true));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return await db.collection("users").doc(uid).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserData(String uid) {
    return db.collection("users").doc(uid).snapshots();
  }
}