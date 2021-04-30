import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

enum Filter {
  ALL,
  TRAM,
  BUS,
}

class DeparturesFilterCubit extends Cubit<Filter> {
  DeparturesFilterCubit() : super(Filter.ALL);

  void toggle() {
    switch (state) {
      case Filter.ALL:
        emit(Filter.TRAM);
        break;
      case Filter.TRAM:
        emit(Filter.BUS);
        break;
      case Filter.BUS:
        emit(Filter.ALL);
    }
  }
}
