import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class AirlyCubit extends Cubit<Airly> {
  final KrkStopsRepository krkStopsRepository;
  final airlyKey = 'airly';
  Installation installation = Installation();
  AirlyCubit(this.krkStopsRepository)
      : super(Airly()
          ..color = "#AAAAAA"
          ..humidity = 0
          ..temperature = 0
          ..caqi = 0) {
    krkStopsRepository.preferencesLoaded.future.then((value) {
      loadAirly();
    });
  }

  void update(Airly airly) => emit(airly);

  void loadAirly() {
    var installationId = krkStopsRepository.preferences.getInt(airlyKey);
    if (installationId == null) {
      installation.id = 8077;
      installation.latitude = 50.062006;
      installation.longitude = 19.940984;
      saveInstallation();
    }
    installation.id = installationId;
    fetchAirly();
  }
  fetchAirly() {
    krkStopsRepository.stub.getAirly(installation).then((response) {
      emit(response);
    });
  }

  saveInstallation() {}
}
