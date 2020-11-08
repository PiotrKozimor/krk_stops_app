import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

class DeparturesEditView extends StatelessWidget {
  final Stop stop;
  DeparturesEditView(this.stop);
  final possibleColors = [
    Colors.red[50],
    Colors.deepPurple[50],
    Colors.lightBlue[50],
    Colors.green[50],
    Colors.yellow[50],
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
                                  .read<DeparturesCubit>()
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
    var bloc = context.watch<DeparturesCubit>();
    return ListView.builder(
      itemCount: bloc.state.length,
      itemBuilder: (context, index) {
        Departure departure = bloc.state[index];
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
    );
  }
}
