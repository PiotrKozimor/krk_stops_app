import 'package:flutter/material.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

import '../departures.dart';

class StopsView extends StatelessWidget {
  final List<Stop> stops;
  StopsView(this.stops) {print("StopsView");}
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
                  // this.model.departures = [];
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
