import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class LastStopsCubit extends Cubit<List<Stop>> {
  final KrkStopsRepository krkStopsRepository;
  static final key = 'last_stops';
  Installation installation = Installation();
  bool searching = false;
  LastStopsCubit(this.krkStopsRepository) : super(List<Stop>.empty()) {
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

  addLast(Stop stop) {
    if (searching) {
      var stops = this.state;
      final indexOfExisting =
          stops.indexWhere((element) => element.id == stop.id);
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

  save(List<Stop> stops) {
    var encodedStops = encode(stops);
    this.krkStopsRepository.preferences.setStringList(key, encodedStops);
    emit(stops);
  }
}
