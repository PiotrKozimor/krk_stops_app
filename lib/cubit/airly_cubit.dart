import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

import '../repository/local_repository.dart';

class AirlyInstallation {
  final Measurement measurement;
  final Installation inst;
  AirlyInstallation(this.measurement, this.inst);
}

class AirlyCubit extends Cubit<AirlyInstallation> {
  final KrkStopsRepository krkStopsRepository;
  static final key = 'airly';
  final LocalRepository local;
  AirlyCubit(this.krkStopsRepository, this.local)
      : super(AirlyInstallation(
            Measurement()
              ..color = 0xAAAAAA
              ..humidity = 0
              ..temperature = 0
              ..caqi = 0,
            Installation()
              ..id = 8077
              ..latitude = 50.062006
              ..longitude = 19.940984)) {
    local.preferencesLoaded.future.then((value) {
      load();
    });
  }

  refetchAirly() {
    krkStopsRepository.stub
        .getAirly(GetMeasurementRequest(id: state.inst.id))
        .then((response) {
      emit(AirlyInstallation(response, state.inst));
    });
  }

  fetchAirly(Installation i) {
    krkStopsRepository.stub
        .getAirly(GetMeasurementRequest(id: i.id))
        .then((response) {
      emit(AirlyInstallation(response, i));
    });
  }

  void load() {
    var encoded = local.preferences.getString(key);
    if (encoded == null) {
      save(state.inst);
    } else {
      fetchAirly(decode(encoded));
    }
  }

  save(Installation i) {
    var encoded = encode(i);
    local.preferences.setString(key, encoded);
    fetchAirly(i);
  }

  Future<Installation> checkId(int id) {
    var request = GetAirlyInstallationRequest()..id = id;
    return krkStopsRepository.stub.getAirlyInstallation(request);
  }

  Future<Installation> findNearest(Position pos) {
    var request = Location()
      ..latitude = pos.latitude
      ..longitude = pos.longitude;
    return krkStopsRepository.stub.findNearestAirlyInstallation(request);
  }

  static String encode(Installation obj) {
    return obj.writeToJson();
  }

  static Installation decode(String encoded) {
    return Installation.fromJson(encoded);
  }

  restore(String encoded) {
    var i = decode(encoded);
    save(i);
  }
}
