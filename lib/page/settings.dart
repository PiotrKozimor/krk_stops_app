import 'package:flutter/material.dart';
import 'package:krk_stops_app/view/backup_view.dart';
import 'package:krk_stops_app/view/installation_view.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text("KrkStops"),
        ),
        body: ListView(
          children: [
            InstallationView(),
            Divider(
              height: 7,
              thickness: 1,
            ),
            BackupView()
          ],
        ));
    return scaf;
  }
}
