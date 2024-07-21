import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/feature_cubit.dart';
import 'package:krk_stops_app/last_stop.dart';
import 'package:krk_stops_app/page/settings.dart';

import '../cubit/airly_cubit.dart';
import '../cubit/departures_cubit.dart';
import '../cubit/stops_cubit.dart';
import '../grpc/krk-stops.pb.dart';
import '../repository/firebase_repository.dart';
import '../search_stops.dart';
import '../view/airly_view.dart';
import '../view/stops_view.dart';
import 'departures.dart';
import 'edit_stops.dart';

class HomePage extends StatelessWidget {
  final LastStops ls;
  final String title;
  HomePage(this.ls, {Key? key, this.title = "KrkStops"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  var s = await showSearch<Stop>(
                      context: context, delegate: SearchStops(ls));
                  if (s != null) {
                    ls.addLast(s);
                    var departuresC = context.read<DeparturesCubit>();
                    departuresC.clear();
                    departuresC.fetch(s);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DeparturesPage(s)));
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
        body: BlocBuilder<FeatureCubit, Features>(builder: (_, features) {
          var children = <Widget>[
            BlocBuilder<StopsCubit, List<Stop>>(
                builder: (_, stops) => StopsView(
                      stops,
                      (Stop s, BuildContext ctx) {
                        var departuresC = ctx.read<DeparturesCubit>();
                        departuresC.clear();
                        departuresC.fetch(s);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DeparturesPage(s)));
                      },
                    ))
          ];
          if (features.airQuality) {
            children.insert(
                0,
                Divider(
                  height: 7,
                  thickness: 1,
                ));
            children.insert(
                0,
                BlocBuilder<AirlyCubit, AirlyInstallation>(
                  builder: (_, airly) => AirlyView(airly.measurement),
                ));
          }
          ;
          return ListView(children: children);
        }));
    return scaf;
  }
}
