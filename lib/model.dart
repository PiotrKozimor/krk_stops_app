import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:krk_stops_frontend_flutter/grpc/krk-stops.pb.dart';
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
  final stopsCompleter = new Completer<List<Stop>>();
  var airly = new Airly();
  var installation = new Installation();
  final channel = ClientChannel('krk-stops.pl',
      port: 8080,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  AppModel() {
    SharedPreferences.getInstance().then((value) {
      this.prefs = value;
      loadStops();
      loadAirly();
      loadDepartures();
    });
    this.airly.color = "#AAAAAA";
    this.stub = KrkStopsClient(this.channel,
        options: CallOptions(timeout: Duration(seconds: 30)));
  }

  void loadAirly() {
    var installationId = this.prefs.getInt(airlyKey);
    if (installationId == null) {
      installation.id = 9914;
      saveInstallation();
    } else {
      installation.id = installationId;
    }
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
    }
    this.stopsCompleter.complete(this.savedStops);
  }

  void saveStops(List<Stop> stops) {
    List<String> rawStops = [];
    for (final stop in stops) {
      rawStops.add(stop.writeToJson());
    }
    this.prefs.setStringList(this.stopsKey, rawStops);
  }

  void loadDepartures() {
    var rawSavedDepartures = prefs.getStringList(departuresKey);
    if (rawSavedDepartures != null) {
      for (final rawSavedDeparture in rawSavedDepartures) {
        savedDepartures.add(Departure.fromJson(rawSavedDeparture));
      }
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

  ResponseFuture<Airly> fetchAirly(Installation installation) {
    final airly = stub.getAirly(installation);
    return airly;
  }
}
