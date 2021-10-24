import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pbgrpc.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

enum Filter {
  ALL,
  TRAM,
  BUS,
}

class FilteredDepartures {
  List<Departure> departures;
  Filter filter;
  FilteredDepartures(this.departures, this.filter);
}

class DeparturesCubit extends Cubit<FilteredDepartures> {
  final KrkStopsRepository krkStopsRepository;
  List<Departure> colors;
  var allDepartures = List<Departure>.empty();
  DeparturesCubit(this.krkStopsRepository, this.colors)
      : super(FilteredDepartures(List<Departure>.empty(), Filter.ALL));

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
      emitWithColors(response.departures, colors);
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

  applyColors(List<Departure> c) {
    emitWithColors(state.departures, c);
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
    emit(FilteredDepartures(allDepartures, Filter.ALL));
  }

  void toggle() {
    switch (state.filter) {
      case Filter.ALL:
        var departuresFiltered = allDepartures
            .where((element) => element.type == Endpoint.TRAM)
            .toList();
        emit(FilteredDepartures(departuresFiltered, Filter.TRAM));
        break;
      case Filter.TRAM:
        var departuresFiltered = allDepartures
            .where((element) => element.type == Endpoint.BUS)
            .toList();
        emit(FilteredDepartures(departuresFiltered, Filter.BUS));
        break;
      case Filter.BUS:
        emit(FilteredDepartures(allDepartures, Filter.ALL));
    }
  }
}
