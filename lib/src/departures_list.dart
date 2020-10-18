import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_frontend_flutter/grpc/krk-stops.pbgrpc.dart';

import '../departures.dart';
import '../model.dart';

class DeparturesList extends StatelessWidget {
  final getIt = GetIt.instance;
  AppModel model;
  final Completer<List<Departure>> _departures;
  DeparturesList(this._departures) {
    model = getIt.get<AppModel>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _departures.future,
      builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
        List<Widget> departuresWidgets = [];
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            for (final departure in snapshot.data) {
              String relativeTime;
              if (departure.relativeTime == 0) {
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
                    color: model.findDepartureColor(departure),
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
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(relativeTime)),
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
          } else {
            departuresWidgets.add(ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 40,
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  // alignment: Alignment.topCenter,
                  child: Text("No departures in 20 minutes."),
                  // )
                  // ],
                )));
          }
        } else if (snapshot.hasError) {
          departuresWidgets.add(ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 40,
              ),
              child: Container(
                // height: 40,
                alignment: Alignment.center,
                child: Text(
                  snapshot.error,
                  style: TextStyle(color: Colors.red),
                ),
              )));
        }
        return ListView(
          children: departuresWidgets,
        );
      },
    );
  }
}
