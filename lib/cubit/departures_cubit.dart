import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pbgrpc.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

import '../repository/local_repository.dart';

class FilteredDepartures {
  List<Departure> departures;
  Endpoint filter;
  FilteredDepartures(this.departures, this.filter);
}

class DeparturesCubit extends Cubit<FilteredDepartures> {
  final KrkStopsRepository krkStopsRepository;
  final LocalRepository local;
  var colors = List<Departure>.empty();
  var allDepartures = List<Departure>.empty();
  static final key = 'departures';
  DeparturesCubit(this.krkStopsRepository, this.local)
      : super(FilteredDepartures(List<Departure>.empty(), Endpoint.ALL)) {
    local.preferencesLoaded.future.then((value) {
      load();
    });
    colors = [
      Departure()
        ..color = 4292998654
        ..direction = "Czerwone Maki P+R"
        ..patternText = "52"
    ];
  }

  Future<void> fetch(Stop stop) {
    var fetched = Completer<void>();
    krkStopsRepository.stub.getDepartures2(stop).then((response) {
      if (response.departures.isEmpty) {
        response.departures
            .add(Departure(direction: "No departures in 20 minutes."));
      }
      response.departures
          .sort((a, b) => a.relativeTime.compareTo(b.relativeTime));
      allDepartures = response.departures;
      emitWithColors(filter(state.filter), colors);
      fetched.complete();
    }).catchError((Object error) {
      fetched.completeError("Could not fetch departures: $error");
    });
    return fetched.future;
  }

  int find(Departure dep) {
    return colors.lastIndexWhere((departure) {
      return departure.direction == dep.direction &&
          departure.patternText == dep.patternText;
    });
  }

  emitWithColors(List<Departure> departures, List<Departure> c) {
    colors = c;
    for (var i = 0; i < departures.length; i++) {
      var index = find(departures[i]);
      if (index == -1) {
        departures[i].color = 0;
      } else {
        departures[i].color = colors[index].color;
      }
    }
    emit(FilteredDepartures(departures, state.filter));
  }

  clear() {
    allDepartures = List<Departure>.empty();
    emit(FilteredDepartures(allDepartures, Endpoint.ALL));
  }

  void toggle() {
    switch (state.filter) {
      case Endpoint.ALL:
        emit(FilteredDepartures(filter(Endpoint.TRAM), Endpoint.TRAM));
        break;
      case Endpoint.TRAM:
        emit(FilteredDepartures(filter(Endpoint.BUS), Endpoint.BUS));
        break;
      case Endpoint.BUS:
        emit(FilteredDepartures(allDepartures, Endpoint.ALL));
    }
  }

  List<Departure> filter(Endpoint e) {
    if (e == Endpoint.ALL) {
      return allDepartures;
    }
    return allDepartures.where((element) => element.type == e).toList();
  }

  setColor(Departure dep, Color color) {
    var departureIndex = find(dep);
    var departureColors = List<Departure>.from(colors);
    if (color == Colors.white) {
      if (departureIndex != -1) {
        departureColors.removeAt(departureIndex);
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

  save(List<Departure> colors) {
    var encoded = encode(colors);
    local.preferences.setStringList(key, encoded);
    emitWithColors(state.departures, colors);
  }

  load() {
    var encoded = local.preferences.getStringList(key);
    if (encoded == null) {
      save(colors);
    } else {
      emitWithColors(state.departures, decode(encoded));
    }
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
}
