import 'dart:async';

import 'package:flutter/material.dart';

import 'grpc/krk-stops.pb.dart';
import 'grpc/krk-stops.pbgrpc.dart';

class DeparturesPage extends StatefulWidget {
  static const routeName = '/departures';
  final Stop stop;
  final KrkStopsClient stub;
  DeparturesPage(this.stop, this.stub);
  @override
  _DeparturesPageState createState() =>
      _DeparturesPageState(this.stop, this.stub);
}

class _DeparturesPageState extends State<DeparturesPage> {
  KrkStopsClient stub;
  Stop stop;
  int departuresIndex = 0;
  Completer fetchedDepartures = new Completer();

  _DeparturesPageState(this.stop, this.stub);
  List<Departure> departures = [];
  @override
  void initState() {
    super.initState();
    this.fetchDepartures();
  }

  void fetchDepartures() {
    this.departuresIndex = 0;
    setState(() {});
    this.stub.getDepartures(this.stop).listen((stop) {
      if (departuresIndex >= this.departures.length) {
        this.departures.add(stop);
      } else {
        this.departures[departuresIndex] = stop;
      }
      setState(() {});
      departuresIndex++;
    }, onError: (error) {

      this.completeFetchedDepartures();
      setState(() {});
    }, onDone: () {
      if (this.departures.length > departuresIndex) {
        this.departures.removeRange(departuresIndex, this.departures.length);
      }
      this.completeFetchedDepartures();
      setState(() {});
    });
  }

  void completeFetchedDepartures() {
    var timer = Timer(Duration(seconds: 1), () => this.fetchedDepartures.complete());
  }

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text(this.stop.name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: 'Edit',
            ),
            IconButton(
                icon: Icon(Icons.favorite), tooltip: 'Remove from saved'),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            this.fetchedDepartures = new Completer();
            this.fetchDepartures();
            return this.fetchedDepartures.future;
          },
          child: ListView.builder(
            itemCount: this.departures.length,
            itemBuilder: (context, index) {
              Departure departure = this.departures[index];
              String relativeTime;
              if (departure.relativeTime == 0) {
                relativeTime = "";
              } else if (departure.relativeTime ~/ 60 < 1) {
                relativeTime = "${departure.relativeTime}s";
              } else {
                var minutes = departure.relativeTime ~/ 60;
                relativeTime = "${minutes}m";
              }
              return Container(
                height: 36,
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
              );
            },
          ),
        ));

    return scaf;
  }
}
