import 'package:flutter/material.dart';
import 'package:krk_stops_app/view/departures_edit_view.dart';

import '../grpc/krk-stops.pb.dart';

class EditDeparturesPage extends StatelessWidget {
  final Stop stop;
  EditDeparturesPage(this.stop, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(stop.name)), body: DeparturesEditView());
  }
}
