import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

import '../circle_color.dart';

class DeparturesEditView extends StatelessWidget {
  DeparturesEditView({Key? key}) : super(key: key);
  final List<Color> possibleColors = [
    Colors.red,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.green,
    Colors.yellow,
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
                              var cubit = context.read<DeparturesCubit>();
                              if (e == Colors.white) {
                                cubit.remove(departure);
                              } else {
                                cubit.setColor(departure, e);
                              }
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
          Color color = Color(departure.color);
          if (departure.color == 0) {
            color = Colors.white;
          }
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
                      color: color,
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
