import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRepository {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  late CollectionReference<Map<String, dynamic>> users;
  FirebaseRepository() {
    Firebase.initializeApp().then((value) {
      auth = FirebaseAuth.instance;
      firestore = FirebaseFirestore.instance;
      users = FirebaseFirestore.instance.collection('users');
    });
  }
}
