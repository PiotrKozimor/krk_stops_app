import 'package:flutter/material.dart';
import 'package:krk_stops_app/cubit/airly_cubit.dart';
import 'package:krk_stops_app/cubit/installation_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirlyView extends StatelessWidget {
  final Airly _airly;
  AirlyView(this._airly);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.brightness_1,
            color: Color(int.parse(_airly.color.substring(1, 7), radix: 16) +
                0xFF000000),
            // color: Color(0xFF999999),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "CAQI: ${_airly.caqi}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            '${_airly.humidity}%',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '${_airly.temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Search stops',
            onPressed: () => context.read<AirlyCubit>().fetchAirly(
              context.read<InstallationCubit>().state
            )),
      ],
    );
  }
}
