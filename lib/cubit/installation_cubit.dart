import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class InstallationCubit extends Cubit<Installation> {
  final KrkStopsRepository krkStopsRepository;
  final installationKey = 'airly';
  Installation installation = Installation();
  InstallationCubit(this.krkStopsRepository)
      : super(Installation()
          ..id = 8077
          ..latitude = 50.062006
          ..longitude = 19.940984) {
    krkStopsRepository.preferencesLoaded.future.then((value) {
      load();
    });
  }

  void load() {
    var encoded = krkStopsRepository.preferences.getString(installationKey);
    if (encoded == null) {
      save(state);
    } else {
      emit(decode(encoded));
    }
  }

  save(Installation obj) {
    var encoded = encode(obj);
    krkStopsRepository.preferences.setString(installationKey, encoded);
    emit(obj);
  }

  Future<Installation> checkId(int id) {
    var request = Installation()..id = id;
    return krkStopsRepository.stub
        .getAirlyInstallation(request)
        .then((response) {
      emit(response);
      return response;
    });
  }

  Future<Installation> findNearest(Position pos) {
    var request = InstallationLocation()
      ..latitude = pos.latitude
      ..longitude = pos.longitude;
    return krkStopsRepository.stub
        .findNearestAirlyInstallation(request)
        .then((response) {
      emit(response);
      return response;
    });
  }

  static String encode(Installation obj) {
    return obj.writeToJson();
  }

  static Installation decode(String encoded) {
    return Installation.fromJson(encoded);
  }

  restore(String encoded) {
    save(decode(encoded));
  }
}
