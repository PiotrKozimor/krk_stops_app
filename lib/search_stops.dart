import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';
import 'package:krk_stops_app/view/stops_view.dart';

import 'grpc/krk-stops.pbgrpc.dart';

class SearchStops extends SearchDelegate<Stop> {
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
      List<Stop> stops = [];
      var _stops = new Completer<List<Stop>>();
      RepositoryProvider.of<KrkStopsRepository>(context)
          .stub
          .searchStops(StopSearch()..query = this.query)
          .listen((value) => stops.add(value), onError: (Object error) {
        final snackBar =
            SnackBar(content: Text('Could not find stops: $error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }, onDone: () {
        _stops.complete(stops);
      });
      return ListView(
        children: [
          FutureBuilder<List<Stop>>(
              future: _stops.future,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Stop>> snapshot) {
                if (!snapshot.hasData) {
                  return Column();
                } else if (snapshot.data.length == 0) {
                  return Container(
                      padding: EdgeInsets.all(12),
                      child: Align(
                        child: Text(
                          "No stops found",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                      ));
                } else {
                  return Column(
                    children: [StopsView(snapshot.data)],
                  );
                }
              })
        ],
      );
    }
    return Column();
  }
}
