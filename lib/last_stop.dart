import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/local_repository.dart';

class LastStops {
  final LocalRepository local;
  static final key = 'last_stops';
  var stops = List<Stop>.empty(growable: true);
  LastStops(this.local) {
    local.preferencesLoaded.future.then((value) {
      load();
    });
  }

  void load() {
    var encoded = local.preferences.getStringList(key);
    if (encoded != null) {
      stops = decode(encoded);
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

  addLast(Stop stop) {
    final indexOfExisting =
        stops.indexWhere((element) => element.id == stop.id);
    if (indexOfExisting != -1) {
      stops.removeAt(indexOfExisting);
    } else if (stops.length >= 10) {
      stops.removeLast();
    }
    stops.insert(0, stop);
    save();
  }

  save() {
    var encodedStops = encode(stops);
    local.preferences.setStringList(key, encodedStops);
  }
}
