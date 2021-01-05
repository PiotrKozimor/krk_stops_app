import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class LastStopsCubit extends Cubit<List<Stop>> {
  final KrkStopsRepository krkStopsRepository;
  static final key = 'last_stops';
  Installation installation = Installation();
  bool searching = false;
  LastStopsCubit(this.krkStopsRepository) : super(List<Stop>()) {
    krkStopsRepository.preferencesLoaded.future.then((value) {
      load();
    });
  }

  void load() {
    List<Stop> stops = [];
    var encoded = krkStopsRepository.preferences.getStringList(key);
    if (encoded != null) {
      stops = decode(encoded);
    }
    emit(stops);
  }

  static List<Stop> decode(List<String> encoded) {
    var stops = List<Stop>();
    for (final stopRaw in encoded) {
      stops.add(Stop.fromJson(stopRaw));
    }
    return stops;
  }

  static List<String> encode(List<Stop> stops) {
    List<String> encoded = [];
    for (final stop in stops) {
      encoded.add(stop.writeToJson());
    }
    return encoded;
  }

  add(Stop stop) {
    if (searching) {
      var stops = this.state;
      final indexOfExisting =
          stops.indexWhere((element) => element.shortName == stop.shortName);
      if (indexOfExisting != -1) {
        stops.removeAt(indexOfExisting);
      } else if (stops.length >= 10) {
        stops.removeLast();
      }
      stops.insert(0, stop);
      save(stops);
    }
  }

  enterSearch() {
    searching = true;
  }

  exitSearch() {
    searching = false;
  }

  // void reorder(int oldIndex, int newIndex) {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }
  //   var stops = List<Stop>.from(state);
  //   final Stop removed = stops.removeAt(oldIndex);
  //   stops.insert(newIndex, removed);
  //   save(stops);
  // }

  save(List<Stop> stops) {
    var encodedStops = encode(stops);
    this.krkStopsRepository.preferences.setStringList(key, encodedStops);
    emit(stops);
  }

  // restore(List<String> encoded) {
  //   emit(decode(encoded));
  // }

  // void remove(Stop stop) {
  //   var toRemove = findIndex(stop);
  //   var newState = List<Stop>.from(state);
  //   newState.removeAt(toRemove);
  //   save(newState);
  // }

  // void add(Stop stop) {
  //   var newState = List<Stop>.from(state);
  //   newState.add(stop);
  //   save(newState);
  // }

  // int findIndex(Stop stop) {
  //   return this.state.lastIndexWhere((element) {
  //     return element.shortName == stop.shortName;
  //   });
  // }
}
