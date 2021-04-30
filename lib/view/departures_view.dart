import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_filter_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

class DeparturesView extends StatelessWidget {
  final List<Departure> departures;
  List<Departure> departuresFiltered = List<Departure>.empty();
  DeparturesView(this.departures);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeparturesFilterCubit, Filter>(
      builder: (context, state) {
        Filter filter = context.read<DeparturesFilterCubit>().state;
        List<Widget> departuresWidgets = [];
        switch (filter) {
          case Filter.ALL:
            departuresFiltered = departures;
            break;
          case Filter.TRAM:
            departuresFiltered = departures
                .where((element) => element.type == Endpoint.TRAM)
                .toList();
            break;
          case Filter.BUS:
            departuresFiltered = departures
                .where((element) => element.type == Endpoint.BUS)
                .toList();
        }
        for (final departure in departuresFiltered) {
          String relativeTime;
          if (!departure.predicted) {
            relativeTime = "";
          } else if (departure.relativeTime ~/ 60 < 1) {
            relativeTime = "${departure.relativeTime}s";
          } else {
            var minutes = departure.relativeTime ~/ 60;
            relativeTime = "${minutes}m";
          }
          departuresWidgets.add(ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 40,
              ),
              child: Container(
                color: Color(departure.color),
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: ConstrainedBox(
                          child: Text(departure.patternText),
                          constraints: BoxConstraints(minWidth: 24),
                        )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(departure.direction),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8), child: Text(relativeTime)),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: ConstrainedBox(
                          child: Text(departure.plannedTime),
                          constraints: BoxConstraints(minWidth: 24),
                        )),
                  ],
                ),
              )));
        }

        return ListView(children: departuresWidgets);
      },
    );

    // }
  }
}
