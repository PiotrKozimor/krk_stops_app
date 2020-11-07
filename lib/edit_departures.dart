import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/view/departures_edit_view.dart';

import 'grpc/krk-stops.pb.dart';

class EditDeparturesPage extends StatelessWidget {
  final Stop stop;
  EditDeparturesPage(this.stop);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(stop.name)),
        body:
            BlocBuilder<DeparturesCubit, List<Departure>>(builder: (context, state) => DeparturesEditView(stop)));
  }
}
