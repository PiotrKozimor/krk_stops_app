import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krk_stops_app/cubit/airly_cubit.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/firebase_repository.dart';

class AuthenticationCubit extends Cubit<String> {
  final FirebaseRepository firebaseRepository;
  final key = 'airly';
  Installation installation = Installation();
  AuthenticationCubit(this.firebaseRepository) : super("") {
    firebaseRepository.auth.authStateChanges().listen((User? user) {
      var email = user?.email;
      emit(email!);
    });
  }

  logIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print(googleUser);
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print(googleAuth);
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    var _ = await FirebaseAuth.instance.signInWithCredential(credential);
  }

  logOut() {
    firebaseRepository.auth.signOut();
    emit("");
  }

  Future<void> removeBackup() {
    return firebaseRepository.users
        .doc(firebaseRepository.auth.currentUser?.uid)
        .delete();
  }

  Future<void> backupSettings(Backup b) {
    return firebaseRepository.users
        .doc(firebaseRepository.auth.currentUser?.uid)
        .set({
      AirlyCubit.key: b.airly,
      StopsCubit.key: b.stops,
      DeparturesCubit.key: b.departures,
    });
  }

  Future<Backup> restoreSettings() {
    var backup = Completer<Backup>();
    firebaseRepository.users
        .doc(firebaseRepository.auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      var data = snapshot.data();
      List<String> stops = [];
      for (final stop in data?[StopsCubit.key]) {
        stops.add(stop);
      }
      List<String> departures = [];
      for (final departure in data?[DeparturesCubit.key]) {
        departures.add(departure);
      }
      backup.complete(Backup()
        ..airly = data?[AirlyCubit.key]
        ..stops = stops
        ..departures = departures);
    }).catchError((Object error) {
      backup.completeError(error);
    });
    return backup.future;
  }
}

class Backup {
  String airly = '';
  var stops = List<String>.empty();
  var departures = List<String>.empty();
}
