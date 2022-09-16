import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

class DeparturesList extends StatelessWidget {
  final List<Departure> departures;
  DeparturesList(this.departures, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> departuresWidgets = [];
    for (final departure in departures) {
      String relativeTime;
      if (!departure.predicted) {
        relativeTime = "";
      } else if (departure.relativeTime ~/ 60 < 1) {
        relativeTime = "${departure.relativeTime}s";
      } else {
        var minutes = departure.relativeTime ~/ 60;
        relativeTime = "${minutes}m";
      }
      Color? color;
      if (departure.color != 0) {
        color = Color(departure.color);
      }
      departuresWidgets.add(Container(
        color: color,
        height: 32,
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 12, left: 12),
                child: Container(
                  child: Text(departure.patternText),
                  width: 26,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(departure.direction),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 8), child: Text(relativeTime)),
            Padding(
                padding: EdgeInsets.only(right: 12),
                child: ConstrainedBox(
                  child: Text(departure.plannedTime),
                  constraints: BoxConstraints(minWidth: 24),
                )),
          ],
        ),
      ));
    }
    return ListView(children: departuresWidgets);
  }
}
