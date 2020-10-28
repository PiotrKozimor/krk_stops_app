import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:krk_stops_frontend_flutter/grpc/krk-stops.pb.dart';
import 'package:krk_stops_frontend_flutter/src/departures_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'grpc/krk-stops.pbgrpc.dart';

class AppModel {
  final getIt = GetIt.instance;
  KrkStopsClient stub;
  final departuresKey = "departures";
  final stopsKey = 'stops';
  final airlyKey = 'airly';
  Stop selectedStop;
  List<Stop> savedStops = [];
  List<Departure> departures = [];
  List<Departure> savedDepartures = [];
  SharedPreferences prefs;
  Function stopsUpdatedCallback;
  Function departuresUpdatedCallback;
  Function airlyUpdatedCallback;
  var stopsCompleter = new Completer<List<Stop>>();
  Completer<List<Departure>> departuresCompleter;
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  CollectionReference users;
  var airly = new Airly();
  var installation = new Installation();
  final channel = ClientChannel('krk-stops.pl',
      port: 8080,
      // port: 10475,
      options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectionTimeout: Duration(seconds: 2)));

  AppModel() {
    Firebase.initializeApp().then((value) {
      auth = FirebaseAuth.instance;
      firestore = FirebaseFirestore.instance;
      users = FirebaseFirestore.instance.collection('users');
    });
    SharedPreferences.getInstance().then((value) {
      this.prefs = value;
      loadStops();
      loadAirly();
      loadDepartures();
    });
    this.airly.color = "#AAAAAA";
    this.stub = KrkStopsClient(this.channel,
        options: CallOptions(timeout: Duration(seconds: 2)));
  }

  Future<void> backupSettings() {
    return users.doc(auth.currentUser.uid).set(
      {
        airlyKey: prefs.getInt(airlyKey),
        stopsKey:  prefs.getStringList(stopsKey),
        departuresKey: prefs.getStringList(departuresKey),
      }
    );
  }

  Completer<void> restoreSettings() {
    var restored = new Completer<void>();
    users.doc(auth.currentUser.uid).get().then((snapshot) {
      var data = snapshot.data();
      prefs.setInt(airlyKey, data[airlyKey]);
      installation.id = data[airlyKey];
      List<String> stops = [];
      for (final stop in data[stopsKey]) {
        stops.add(stop);
      }
      savedStops = [];
      for (final stopRaw in stops) {
        savedStops.add(Stop.fromJson(stopRaw));
      }
      saveStops(savedStops);
      List<String> departures = [];
      for (final departure in data[departuresKey]) {
        departures.add(departure);
      }
      prefs.setStringList(departuresKey, departures);
      savedDepartures = [];
      for (final rawSavedDeparture in departures) {
        savedDepartures.add(Departure.fromJson(rawSavedDeparture));
      }
      if (departuresUpdatedCallback != null) {
        departuresUpdatedCallback();
      }
      restored.complete();
    }).catchError((Object error) {
      restored.completeError(error);
    });
    return restored;
  }

  Future<void> removeBackup() {
    return users.doc(auth.currentUser.uid).delete();
  }

  void loadAirly() {
    var installationId = this.prefs.getInt(airlyKey);
    if (installationId == null) {
      installation.id = 8077;
      installation.latitude = 50.062006;
      installation.longitude = 19.940984;
      saveInstallation();
    } else {
      installation.id = installationId;
    }
    fetchAirly(installation);
  }

  void saveInstallation() {
    this.prefs.setInt(airlyKey, installation.id);
  }

  void loadStops() {
    // this.prefs.remove(this.stops);
    var stopsRaw = this.prefs.getStringList(this.stopsKey);
    if (stopsRaw == null) {
      this.savedStops = [
        Stop()
          ..name = 'Rondo Mogilskie'
          ..shortName = '125',
        Stop()
          ..name = 'Rondo Matecznego'
          ..shortName = '610'
      ];
      saveStops(savedStops);
    } else {
      for (final stopRaw in stopsRaw) {
        this.savedStops.add(Stop.fromJson(stopRaw));
      }
      stopsCompleter = new Completer<List<Stop>>();
      stopsUpdatedCallback();
      stopsCompleter.complete(savedStops);
    }
  }

  void saveStops(List<Stop> stops) {
    stopsCompleter = new Completer<List<Stop>>();
    List<String> rawStops = [];
    for (final stop in stops) {
      rawStops.add(stop.writeToJson());
    }
    this.prefs.setStringList(this.stopsKey, rawStops);
    stopsUpdatedCallback();
    stopsCompleter.complete(stops);
  }

  void loadDepartures() {
    var rawSavedDepartures = prefs.getStringList(departuresKey);
    if (rawSavedDepartures != null) {
      for (final rawSavedDeparture in rawSavedDepartures) {
        savedDepartures.add(Departure.fromJson(rawSavedDeparture));
      } 
    }else {
        savedDepartures = [
          Departure()
          ..color=4292998654
          ..direction="Czerwone Maki P+R"
          ..patternText="52"
        ];
        saveDepartures();
      }
  }

  void saveDepartures() {
    List<String> rawDepartures = [];
    for (final departure in savedDepartures) {
      rawDepartures.add(departure.writeToJson());
    }
    prefs.setStringList(departuresKey, rawDepartures);
  }

  Color findDepartureColor(Departure departureToColor) {
    var departureIndex = savedDepartures.lastIndexWhere((departure) {
      return departure.direction == departureToColor.direction &&
          departure.patternText == departureToColor.patternText;
    });
    if (departureIndex == -1) {
      return null;
    } else {
      Color color = Color(savedDepartures[departureIndex].color);
      if (color == Colors.white) {
        return null;
      } else {
        return color;
      }
    }
  }

  void fetchAirly(Installation installation) {
    stub.getAirly(installation).then((airlyFetched) {
      airly = airlyFetched;
      airlyUpdatedCallback();
    });
  }
}
