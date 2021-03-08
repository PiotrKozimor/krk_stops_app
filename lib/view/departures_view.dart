import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

class DeparturesView extends StatelessWidget {
  final List<Departure> departures;
  DeparturesView(this.departures);
  @override
  Widget build(BuildContext context) {
    List<Widget> departuresWidgets = [];
    // if (departures.length == 0) {
    //   departuresWidgets.add(ConstrainedBox(
    //       constraints: BoxConstraints(
    //         minHeight: 40,
    //       ),
    //       child: Container(
    //         padding: EdgeInsets.all(8),
    //         child: Text("No departures in 20 minutes."),
    //         // )
    //         // ],
    //       )));
    // } else {
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
    // }
    return ListView(
      children: departuresWidgets,
    );
  }
}
