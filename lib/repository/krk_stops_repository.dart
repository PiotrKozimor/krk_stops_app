import 'package:grpc/grpc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pbgrpc.dart';

class KrkStopsRepository {
  late KrkStopsClient stub;
  final channel = ClientChannel(
    'apitramsku.cozymore.dev',
  );

  KrkStopsRepository() {
    this.stub = KrkStopsClient(this.channel);
  }
}
