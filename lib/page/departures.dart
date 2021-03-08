import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:krk_stops_app/view/departures_view.dart';

import 'edit_departures.dart';
import '../grpc/krk-stops.pb.dart';
import '../grpc/krk-stops.pbgrpc.dart';

class DeparturesPage extends StatelessWidget {
  final Stop stop;
  DeparturesPage(this.stop);

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text(stop.name),
          actions: <Widget>[
            BlocBuilder<StopsCubit, List<Stop>>(builder: (context, state) {
              var bloc = context.watch<StopsCubit>();
              if (bloc.findIndex(stop) > -1) {
                return IconButton(
                  icon: Icon(Icons.favorite),
                  tooltip: 'Remove from saved',
                  onPressed: () {
                    bloc.removeFav(stop);
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.favorite_outline),
                  tooltip: 'Add to saved',
                  onPressed: () {
                    bloc.addFav(stop);
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
                    builder: (context) => EditDeparturesPage(this.stop)));
          },
        ),
        body: RefreshIndicator(
            onRefresh: () {
              return context.read<DeparturesCubit>().fetch(stop);
            },
            child: BlocBuilder<DeparturesCubit, List<Departure>>(
                builder: (context, state) => DeparturesView(state))));
    return scaf;
  }
}
