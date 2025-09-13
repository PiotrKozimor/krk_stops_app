import 'package:flutter/material.dart';
import 'package:krk_stops_app/view/legal_view.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
      appBar: AppBar(
        title: Text("KrkStops"),
      ),
      body: LegalView(),
    );

    return scaf;
  }
}
