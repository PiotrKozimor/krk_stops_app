import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';

import 'grpc/krk-stops.pbgrpc.dart';

class EditStopsPage extends StatelessWidget {
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
                    context.bloc<StopsCubit>().reorder(oldIndex, newIndex);
                  });
            }));
  }
}
