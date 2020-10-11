import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_frontend_flutter/grpc/krk-stops.pbgrpc.dart';

import '../departures.dart';
import '../model.dart';

class StopsList extends StatelessWidget {
  final getIt = GetIt.instance;
  AppModel model;
  final Completer<List<Stop>> _stops;
  StopsList(this._stops) {
    model = getIt.get<AppModel>();
  }

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
                  // height: 40,
                  padding: EdgeInsets.all(12),
                  child: Align(
                    child: Text(stop.name,
                      style: Theme.of(context).textTheme.bodyText1,),
                    alignment: AlignmentDirectional.centerStart,
                  )),
              onTap: () {
                this.model.departures = [];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeparturesPage(stop)));
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
