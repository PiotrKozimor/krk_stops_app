import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pbgrpc.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class DeparturesCubit extends Cubit<List<Departure>> {
  final KrkStopsRepository krkStopsRepository;
  var coloredDepartures = List<Departure>.empty();
  static final key = 'departures';
  DeparturesCubit(this.krkStopsRepository)
      : super([
          Departure()
            ..color = 4292998654
            ..direction = "Czerwone Maki P+R"
            ..patternText = "52"
        ]) {
    krkStopsRepository.preferencesLoaded.future.then((value) {
      load();
    });
  }
  load() {
    var encoded = krkStopsRepository.preferences.getStringList(key);
    if (encoded == null) {
      coloredDepartures = [
        Departure()
          ..color = 4292998654
          ..direction = "Czerwone Maki P+R"
          ..patternText = "52"
      ];
      save(coloredDepartures);
    } else {
      coloredDepartures = decode(encoded);
    }
  }

  clean() {
    emit(List<Departure>.empty());
  }

  Future<void> fetch(Stop request) {
    var fetched = Completer<void>();
    krkStopsRepository.stub.getDepartures2(request).then((response) {
      if (response.departures.isEmpty) {
        response.departures
            .add(Departure(direction: "No departures in 20 minutes."));
      }
      response.departures
          .sort((a, b) => a.relativeTime.compareTo(b.relativeTime));
      emit(applyColor(response.departures));
      fetched.complete();
    }).catchError((Object error) {
      fetched.completeError("Could not fetch departures: $error");
    });
    return fetched.future;
  }

  static List<Departure> decode(List<String> encoded) {
    var departures = List<Departure>.generate(
        encoded.length, (index) => Departure.fromJson(encoded[index]));
    return departures;
  }

  static List<String> encode(List<Departure> departures) {
    List<String> encoded = [];
    for (final stop in departures) {
      encoded.add(stop.writeToJson());
    }
    return encoded;
  }

  save(List<Departure> departures) {
    coloredDepartures = departures;
    var encoded = encode(departures);
    krkStopsRepository.preferences.setStringList(key, encoded);
  }

  restore(List<String> encoded) {
    save(decode(encoded));
  }

  int find(Departure dep) {
    return coloredDepartures.lastIndexWhere((departure) {
      return departure.direction == dep.direction &&
          departure.patternText == dep.patternText;
    });
  }

  List<Departure> applyColor(List<Departure> toColor) {
    for (var i = 0; i < toColor.length; i++) {
      var index = find(toColor[i]);
      if (index == -1) {
        toColor[i].color = 0;
      } else {
        toColor[i].color = coloredDepartures[index].color;
      }
    }
    return List<Departure>.from(toColor);
  }

  setColor(Departure dep, Color color) {
    var departureIndex = find(dep);
    if (color == Colors.white) {
      if (departureIndex != -1) {
        coloredDepartures.removeAt(departureIndex);
      }
    } else {
      if (departureIndex == -1) {
        coloredDepartures.add(Departure()
          ..patternText = dep.patternText
          ..direction = dep.direction
          ..color = color.value);
      } else {
        coloredDepartures[departureIndex].color = color.value;
      }
    }
    save(coloredDepartures);
    emit(applyColor(state));
  }

  Color getColor(Departure dep) {
    var departureIndex = find(dep);
    if (departureIndex == -1) {
      return Colors.white;
    } else {
      return Color(coloredDepartures[departureIndex].color);
    }
  }
}
