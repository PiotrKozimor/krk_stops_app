import 'package:flutter/material.dart';
import 'package:krk_stops_app/cubit/airly_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirlyView extends StatelessWidget {
  final Measurement _airly;
  AirlyView(this._airly);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.brightness_1,
            color: Color(_airly.color + 0xFF000000),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "CAQI: ${_airly.caqi}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            '${_airly.humidity}%',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '${_airly.temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<AirlyCubit>().refetchAirly()),
      ],
    );
  }
}
