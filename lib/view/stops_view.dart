import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/page/departures.dart';

class StopsView extends StatelessWidget {
  final List<Stop> stops;
  final Function(Stop, BuildContext) tap;
  StopsView(this.stops, this.tap);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: stops
          .map((e) => InkWell(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              onTap: () => tap(e, context)))
          .toList(),
    );
  }
}
