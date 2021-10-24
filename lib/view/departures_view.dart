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
      departuresWidgets.add(ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 40,
          ),
          child: Container(
            color: Color(departure.color),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: ConstrainedBox(
                      child: Text(departure.patternText),
                      constraints: BoxConstraints(minWidth: 24),
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(departure.direction),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8), child: Text(relativeTime)),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: ConstrainedBox(
                      child: Text(departure.plannedTime),
                      constraints: BoxConstraints(minWidth: 24),
                    )),
              ],
            ),
          )));
    }
    return ListView(children: departuresWidgets);
  }
}
