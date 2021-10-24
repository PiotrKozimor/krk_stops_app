import 'package:grpc/grpc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pbgrpc.dart';

class KrkStopsRepository {
  late KrkStopsClient stub;
  final channel = ClientChannel(
    'krkstops-1.germanywestcentral.cloudapp.azure.com',
    port: 9090,
  );

  KrkStopsRepository() {
    this.stub = KrkStopsClient(this.channel);
  }
}
