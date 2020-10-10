import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krk_stops_frontend_flutter/grpc/krk-stops.pbgrpc.dart';

import '../departures.dart';

class StopsList extends StatelessWidget {
  final KrkStopsClient stub;
  final Completer<List<Stop>> _stops;
  final List<Stop> savedStops;
  final void Function(List<Stop>) stopsEditedCallback;
  StopsList(this._stops, this.stub, this.savedStops, this.stopsEditedCallback);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _stops.future,
      builder: (BuildContext context, AsyncSnapshot<List<Stop>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> stopsWidgets = [];
          for (final stop in snapshot.data) {
            stopsWidgets.add(InkWell(
              child: Container(
                  height: 50,
                  child: Align(
                    child: Text(stop.name),
                    alignment: AlignmentDirectional.centerStart,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeparturesPage(stop, stub, savedStops, stopsEditedCallback)));
              },
            ));
          }
          return ListView(
            children: stopsWidgets,
            padding: const EdgeInsets.all(8),
          );
        } else {
          return Column();
        }
      },
    );
  }
}
