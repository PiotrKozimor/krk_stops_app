import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class FirebaseRepository {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  Completer<void> initialized = Completer<void>();
  late CollectionReference<Map<String, dynamic>> users;
  FirebaseRepository() {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      auth = FirebaseAuth.instance;
      firestore = FirebaseFirestore.instance;
      users = FirebaseFirestore.instance.collection('users');
      initialized.complete();
    });
  }
}
