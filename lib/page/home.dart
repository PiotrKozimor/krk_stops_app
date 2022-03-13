import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/page/settings.dart';

import '../cubit/airly_cubit.dart';
import '../cubit/last_stops_cubit.dart';
import '../cubit/stops_cubit.dart';
import '../grpc/krk-stops.pb.dart';
import '../repository/firebase_repository.dart';
import '../search_stops.dart';
import '../view/airly_view.dart';
import '../view/stops_view.dart';
import 'departures.dart';
import 'edit_stops.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, this.title = "KrkStops"}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  context.read<LastStopsCubit>().enterSearch();
                  var stopSearched = await showSearch<Stop>(
                      context: context, delegate: SearchStops());
                  context.read<LastStopsCubit>().exitSearch()();
                  if (stopSearched != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DeparturesPage(stopSearched)));
                  }
                }),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RepositoryProvider<FirebaseRepository>(
                            create: (_) => FirebaseRepository(),
                            child: SettingsPage())));
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => EditStopsPage()));
          },
        ),
        body: ListView(
          children: [
            BlocBuilder<AirlyCubit, Airly>(
                builder: (_, airly) => AirlyView(airly)),
            Divider(
              height: 7,
              thickness: 1,
            ),
            BlocBuilder<StopsCubit, List<Stop>>(
                builder: (_, stops) => StopsView(stops))
          ],
        ));
    return scaf;
  }
}
