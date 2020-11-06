import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class StopsCubit extends Cubit<List<Stop>> {
  final KrkStopsRepository krkStopsRepository;
  final stopsKey = 'stops';
  Installation installation = Installation();
  StopsCubit(this.krkStopsRepository) : super(List<Stop>()) {
    krkStopsRepository.preferencesLoaded.future.then((value) {
      loadStops();
    });
  }

  // void update(Airly airly) => emit(airly);

  void loadStops() {
    var stopsRaw = krkStopsRepository.preferences.getStringList(stopsKey);
    if (stopsRaw == null) {
      var stops = [
        Stop()
          ..name = 'Rondo Mogilskie'
          ..shortName = '125',
        Stop()
          ..name = 'Rondo Matecznego'
          ..shortName = '610'
      ];
      // emit(stops);
      saveStops(stops);
    } else {
      var stops = List<Stop>();
      for (final stopRaw in stopsRaw) {
        stops.add(Stop.fromJson(stopRaw));
      }
      emit(stops);
    }
    // var tim = Timer.periodic(Duration(seconds: 1), (t) {
    //   var stops = List<Stop>.from(state);
    //   stops[0].name += "a";
    //   print(stops == state);
    //   emit(stops);
    // });
  }

  void reorderStops(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var stops = List<Stop>.from(state);
    final Stop removed = stops.removeAt(oldIndex);
    stops.insert(newIndex, removed);
    saveStops(stops);
    // print(state == stops);
    // emit(stops);
  }

  saveStops(List<Stop> stops) {
    List<String> rawStops = [];
    for (final stop in stops) {
      rawStops.add(stop.writeToJson());
    }
    this.krkStopsRepository.preferences.setStringList(this.stopsKey, rawStops);
    emit(stops);
  }
}
