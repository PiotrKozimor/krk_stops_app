import 'package:bloc/bloc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';

class AirlyCubit extends Cubit<Airly> {
  final KrkStopsRepository krkStopsRepository;
  static final key = 'airly';
  Installation installation = Installation();
  AirlyCubit(this.krkStopsRepository)
      : super(Airly()
          ..color = 0xAAAAAA
          ..humidity = 0
          ..temperature = 0
          ..caqi = 0);

  Future<Airly> fetchAirly(Installation request) {
    return krkStopsRepository.stub.getAirly(request).then((response) {
      emit(response);
      return response;
    });
  }
}
