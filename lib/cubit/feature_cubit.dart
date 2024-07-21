import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/repository/firebase_repository.dart';
import 'package:krk_stops_app/repository/local_repository.dart';

class FeatureCubit extends Cubit<Features> {
  final LocalRepository localRepository;
  FeatureCubit(this.localRepository) : super(Features(false)) {
    localRepository.preferencesLoaded.future.then((_) {
      load();
    });
  }
  void load() {
    var airQuality = localRepository.preferences.getBool("airQuality");
    if (airQuality != null) {
      emit(Features(airQuality));
    }
  }

  void save(Features features) {
    localRepository.preferences.setBool("airQuality", features.airQuality);
    emit(features);
  }

  void update(FirebaseRepository firebaseRepository) {
    if (firebaseRepository.auth.currentUser != null) {
      var config_uid = firebaseRepository.auth.currentUser!.uid + "_config";
      firebaseRepository.users.doc(config_uid).get().then(
        (value) {
          var data = value.data();
          if (data != null) {
            if (data["airQuality"] != null) {
              save(Features(data["airQuality"]));
            }
          }
        },
      );
    }
  }
}

class Features {
  final bool airQuality;
  Features(this.airQuality);
}
