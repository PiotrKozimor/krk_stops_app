import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krk_stops_frontend_flutter/src/stops_list.dart';

import 'grpc/krk-stops.pbgrpc.dart';

class SearchStops extends SearchDelegate<Stop> {
  final KrkStopsClient stub;
  List<Stop> stops = [];
  SearchStops(this.stub);

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
      stops=[];
      var request = this.stub.searchStops(StopSearch()..query = this.query);
      var _stops = new Completer<List<Stop>>();
      request.listen((value) {
        stops.add(value);
      }, onDone: () {
        _stops.complete(stops);
      }, onError: (error) {
        _stops.complete(stops);
      });
      return StopsList(_stops, stub);
    }
    return Column();
  }
}

