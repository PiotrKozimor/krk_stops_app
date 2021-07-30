import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:krk_stops_app/grpc/krk-stops.pbgrpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KrkStopsRepository {
  late SharedPreferences preferences;
  late KrkStopsClient stub;
  final preferencesLoaded = Completer<void>();
  final channel =
      ClientChannel('krkstops.germanywestcentral.cloudapp.azure.com',
          port: 8080,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ));

  KrkStopsRepository() {
    SharedPreferences.getInstance().then((value) {
      this.preferences = value;
      this.preferencesLoaded.complete();
    });
    this.stub = KrkStopsClient(this.channel);
  }
}
