import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/local_repository.dart';

class DepartureColorCubit extends Cubit<List<Departure>> {
  final LocalRepository local;
  static final key = 'departures';
  DepartureColorCubit(this.local)
      : super([
          Departure()
            ..color = 4292998654
            ..direction = "Czerwone Maki P+R"
            ..patternText = "52"
        ]) {
    local.preferencesLoaded.future.then((value) {
      load();
    });
  }

  load() {
    var encoded = local.preferences.getStringList(key);
    if (encoded == null) {
      save(state);
    } else {
      emit(decode(encoded));
    }
  }

  save(List<Departure> departures) {
    var encoded = encode(departures);
    local.preferences.setStringList(key, encoded);
    emit(departures);
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

  setColor(Departure dep, Color color) {
    var departureIndex = find(dep);
    var departureColors = List<Departure>.from(state);
    if (color == Colors.white) {
      if (departureIndex != -1) {
        state.removeAt(departureIndex);
      }
    } else {
      if (departureIndex == -1) {
        departureColors.add(Departure()
          ..patternText = dep.patternText
          ..direction = dep.direction
          ..color = color.value);
      } else {
        departureColors[departureIndex].color = color.value;
      }
    }
    save(departureColors);
  }

  restore(List<String> encoded) {
    save(decode(encoded));
  }

  int find(Departure dep) {
    return state.lastIndexWhere((departure) {
      return departure.direction == dep.direction &&
          departure.patternText == dep.patternText;
    });
  }
}
