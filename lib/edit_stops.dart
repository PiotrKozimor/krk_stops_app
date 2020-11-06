import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'grpc/krk-stops.pbgrpc.dart';
import 'model.dart';

class EditStopsPage extends StatelessWidget {
  // EditStopsPage();
//   @override
//   _EditStopsState createState() => _EditStopsState();
// }

// class _EditStopsState extends State<EditStopsPage> {
//   final getIt = GetIt.instance;
//   AppModel model;
//   String airlyError;
//   _EditStopsState() {
//     model = getIt.get<AppModel>();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("KrkStops"),
        ),
        body: BlocBuilder<StopsCubit, List<Stop>>(
            cubit: context.bloc<StopsCubit>(),
            builder: (context, state) {
              return ReorderableListView(
                  children: state
                      .map((e) => ListTile(
                            key: Key("${e.shortName}"),
                            title: Text("${e.name}"),
                            trailing: Icon(Icons.menu),
                          ))
                      .toList(),
                  onReorder: (int oldIndex, int newIndex) {
                    context.bloc<StopsCubit>().reorderStops(oldIndex, newIndex);
                    // model.saveStops(this.model.savedStops);
                  });
            }));
  }
}
