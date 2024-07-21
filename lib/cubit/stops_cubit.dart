import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/local_repository.dart';

class StopsCubit extends Cubit<List<Stop>> {
  final LocalRepository local;
  static final key = 'stops';
  StopsCubit(this.local) : super(List<Stop>.empty()) {
    local.preferencesLoaded.future.then((value) {
      load();
    });
  }

  void load() {
    var encoded = local.preferences.getStringList(key);
    if (encoded == null) {
      var stops = [
        Stop()
          ..name = 'Rondo Mogilskie'
          ..id = 125,
        Stop()
          ..name = 'Rondo Matecznego'
          ..id = 610
      ];
      save(stops);
    } else {
      var stops = decode(encoded);
      emit(stops);
    }
  }

  static List<Stop> decode(List<String> encoded) {
    var stops = List<Stop>.generate(
        encoded.length, (index) => Stop.fromJson(encoded[index]));
    return stops;
  }

  static List<String> encode(List<Stop> stops) {
    List<String> encoded = [];
    for (final stop in stops) {
      encoded.add(stop.writeToJson());
    }
    return encoded;
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var stops = List<Stop>.from(state);
    final Stop removed = stops.removeAt(oldIndex);
    stops.insert(newIndex, removed);
    save(stops);
  }

  save(List<Stop> stops) {
    var encodedStops = encode(stops);
    this.local.preferences.setStringList(key, encodedStops);
    emit(stops);
  }

  restore(List<String> encoded) {
    save(decode(encoded));
  }

  void removeFav(Stop stop) {
    var toRemove = findIndex(state, stop);
    var newState = List<Stop>.from(state);
    newState.removeAt(toRemove);
    save(newState);
  }

  void addFav(Stop stop) {
    var newState = List<Stop>.from(state);
    newState.add(stop);
    save(newState);
  }

  static int findIndex(List<Stop> stops, Stop stop) {
    return stops.lastIndexWhere((element) {
      return element.id == stop.id;
    });
  }
}
