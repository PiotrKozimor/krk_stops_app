import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get_it/get_it.dart';

import 'grpc/krk-stops.pb.dart';
import 'model.dart';

class EditDeparturesPage extends StatefulWidget {
  final Stop stop;
  EditDeparturesPage(this.stop);
  @override
  _EditDeparturesState createState() => _EditDeparturesState(stop);
}

class _EditDeparturesState extends State<EditDeparturesPage> {
  final getIt = GetIt.instance;
  final possibleColors = [
    Colors.red[50],
    Colors.deepPurple[50],
    Colors.lightBlue[50],
    Colors.green[50],
    Colors.yellow[50],
    Colors.white,
  ];
  AppModel model;
  final Stop stop;
  _EditDeparturesState(this.stop) {
    model = getIt.get<AppModel>();
  }
  @override
  void initState() {
    super.initState();
  }

  Widget Function(BuildContext) showColorDialogBuilder(Departure departure) {
    return (context) {
      return Dialog(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: generateColorsRow(
                            possibleColors.getRange(0, 3), departure)),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: generateColorsRow(
                            possibleColors.getRange(3, 6), departure))
                  ])));
    };
  }

  List<Widget> generateColorsRow(Iterable<Color> colors, Departure departure) {
    List<Widget> widgets = [];
    for (final color in colors) {
      widgets.add(Padding(
          padding: EdgeInsets.all(8),
          child: CircleColor(
            circleSize: 32,
            color: color,
            onColorChoose: () {
              saveDepartureColor(departure, color);
              Navigator.pop(context);
            },
          )));
    }
    return widgets;
  }

  saveDepartureColor(Departure departureColored, Color color) {
    var departureIndex = model.savedDepartures.lastIndexWhere((departure) {
      return departure.direction == departureColored.direction &&
          departure.patternText == departureColored.patternText;
    });
    if (departureIndex == -1) {
      setState(() {
        model.savedDepartures.add(Departure()
          ..patternText = departureColored.patternText
          ..direction = departureColored.direction
          ..color = color.value);
      });
    } else {
      setState(() {
        model.savedDepartures[departureIndex].color = color.value;
      });
    }
    model.saveDepartures();
    model.departuresUpdatedCallback();
  }

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(title: Text(this.stop.name)),
        body: ListView.builder(
          itemCount: this.model.departures.length,
          itemBuilder: (context, index) {
            Departure departure = this.model.departures[index];
            var color = model.findDepartureColor(departure);
            if (color == null) {
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
        ));

    return scaf;
  }
}
