import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/l10n/app_localizations.dart';
import 'package:krk_stops_app/last_stop.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';
import 'package:krk_stops_app/view/stops_view.dart';

import 'grpc/krk-stops.pbgrpc.dart';

class SearchStops extends SearchDelegate<Stop> {
  final LastStops ls;
  SearchStops(this.ls);
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
    if (this.query.length > 1) {
      var _stops = new Completer<List<Stop>>();
      RepositoryProvider.of<KrkStopsRepository>(context)
          .stub
          .searchStops2(SearchStops2Request()..query = this.query)
          .then((response) {
        _stops.complete(response.stops);
      }).catchError((Object error) {
        final snackBar = SnackBar(
            content: Text(
          AppLocalizations.of(context)!.stopsSearchError,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      return ListView(
        children: [
          FutureBuilder<List<Stop>>(
              future: _stops.future,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Stop>> snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data!.length == 0) {
                    return Container(
                        padding: EdgeInsets.all(12),
                        child: Align(
                          child: Text(
                            "No stops found",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          alignment: AlignmentDirectional.centerStart,
                        ));
                  } else {
                    return StopsView(
                      snapshot.data!,
                      (s, ctx) => close(context, s),
                    );
                  }
                }
                return Column();
              })
        ],
      );
    } else {
      return StopsView(ls.stops, (s, ctx) => close(context, s));
    }
  }
}
