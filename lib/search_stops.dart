import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_frontend_flutter/src/stops_list.dart';

import 'grpc/krk-stops.pbgrpc.dart';
import 'model.dart';

class SearchStops extends SearchDelegate<Stop> {
  final getIt = GetIt.instance;
  AppModel model;
  SearchStops() {
    model = getIt.get<AppModel>();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length > 2) {
      List<Stop> stops=[];
      var request = this.model.stub.searchStops(StopSearch()..query = this.query);
      var _stops = new Completer<List<Stop>>();
      request.listen((value) {
        stops.add(value);
      }, onDone: () {
        _stops.complete(stops);
      }, onError: (error) {
        _stops.complete(stops);
      });
      return StopsList(_stops);
    }
    return Column();
  }
}

