import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseRepository {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  CollectionReference users;
  FirebaseRepository() {
    Firebase.initializeApp().then((value) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      auth = FirebaseAuth.instance;
      firestore = FirebaseFirestore.instance;
      users = FirebaseFirestore.instance.collection('users');
    });
  }
}
