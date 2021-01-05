import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/last_stops_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:krk_stops_app/page/departures.dart';

class StopsView extends StatelessWidget {
  final List<Stop> stops;
  StopsView(this.stops);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: stops
          .map((e) => InkWell(
                child: Container(
                    padding: EdgeInsets.all(12),
                    child: Align(
                      child: Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      alignment: AlignmentDirectional.centerStart,
                    )),
                onTap: () {
                  context.read<LastStopsCubit>().add(e);
                  context.read<DeparturesCubit>().clean();
                  context.read<DeparturesCubit>().fetch(e);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeparturesPage(e)));
                },
              ))
          .toList(),
    );
  }
}
