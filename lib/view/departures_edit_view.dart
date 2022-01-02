import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departure_color_cubit.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

import '../circle_color.dart';

class DeparturesEditView extends StatelessWidget {
  DeparturesEditView({Key? key}) : super(key: key);
  final List<Color> possibleColors = [
    Colors.red.shade50,
    Colors.deepPurple.shade50,
    Colors.lightBlue.shade50,
    Colors.green.shade50,
    Colors.yellow.shade50,
    Colors.white,
  ];
  Widget Function(BuildContext) showColorDialogBuilder(Departure departure) {
    return (context) {
      return Dialog(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 200,
                height: 200,
                child: GridView.count(
                    crossAxisCount: 3,
                    children: possibleColors.map((e) {
                      return Padding(
                          padding: EdgeInsets.all(8),
                          child: CircleColor(
                            circleSize: 32,
                            color: e,
                            onColorChoose: () {
                              context
                                  .read<DepartureColorCubit>()
                                  .setColor(departure, e);
                              Navigator.pop(context);
                            },
                          ));
                    }).toList()),
              )));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeparturesCubit, FilteredDepartures>(
      builder: (_, state) => ListView.builder(
        itemCount: state.departures.length,
        itemBuilder: (_, index) {
          Departure departure = state.departures[index];
          return Container(
            height: 40,
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
                    padding: EdgeInsets.all(8),
                    child: CircleColor(
                      color: Color(departure.color),
                      circleSize: 32,
                      onColorChoose: () {
                        showDialog(
                            context: context,
                            builder: showColorDialogBuilder(departure));
                      },
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
