import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:krk_stops_app/view/departures_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/departures_cubit.dart';
import '../grpc/krk-stops.pb.dart';
import '../grpc/krk-stops.pbgrpc.dart';
import 'edit_departures.dart';

var iconFromFilter = {
  Endpoint.ALL: Icons.filter_alt,
  Endpoint.TRAM: Icons.tram,
  Endpoint.BUS: Icons.directions_bus,
};

class DeparturesPage extends StatelessWidget {
  final Stop stop;
  DeparturesPage(this.stop, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(stop.name),
          actions: <Widget>[
            BlocBuilder<DeparturesCubit, FilteredDepartures>(
              builder: (_, state) {
                return IconButton(
                  icon: Icon(iconFromFilter[state.filter]),
                  tooltip: AppLocalizations.of(context)!.departureFilterbyType,
                  onPressed: () {
                    context.read<DeparturesCubit>().toggle();
                  },
                );
              },
            ),
            BlocBuilder<StopsCubit, List<Stop>>(builder: (_, state) {
              if (StopsCubit.findIndex(state, stop) > -1) {
                return IconButton(
                  icon: Icon(Icons.favorite),
                  tooltip: AppLocalizations.of(context)!.savedStopsRemove,
                  onPressed: () {
                    context.read<StopsCubit>().removeFav(stop);
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.favorite_outline),
                  tooltip: AppLocalizations.of(context)!.savedStopsAdd,
                  onPressed: () {
                    context.read<StopsCubit>().addFav(stop);
                  },
                );
              }
            })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => EditDeparturesPage(this.stop)));
          },
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return context.read<DeparturesCubit>().fetch(stop);
          },
          child: BlocBuilder<DeparturesCubit, FilteredDepartures>(
              builder: (context, state) => DeparturesList(state.departures)),
        ));
  }
}
