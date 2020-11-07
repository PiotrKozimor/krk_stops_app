import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/authentication_cubit.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/installation_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';

class BackupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = context.bloc<AuthenticationCubit>();
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(12),
            child: Text(
              "Cloud Backup",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .apply(color: Theme.of(context).primaryColorDark),
            )),
        BlocBuilder<AuthenticationCubit, User>(builder: (context, state) {
          if (state == null) {
            return Column(children: [
              Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Please log in to backup settings",
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: RaisedButton(
                    child: Text(
                      "LOG IN",
                    ),
                    onPressed: () async {
                      bloc.logIn();
                    },
                  )),
            ]);
          }
          var installationC = context.bloc<InstallationCubit>();
          var stopsC = context.bloc<StopsCubit>();
          var departuresC = context.bloc<DeparturesCubit>();
          return Column(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Logged as ${state.email}",
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: RaisedButton(
                    child: Text(
                      "LOG OUT",
                    ),
                    onPressed: () async {
                      bloc.logOut();
                    },
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: RaisedButton(
                      child: Text(
                        "BACKUP SETTINGS",
                      ),
                      onPressed: () async {
                        var backup = Backup()
                          ..airly =
                              InstallationCubit.encode(installationC.state)
                          ..stops = StopsCubit.encode(stopsC.state)
                          ..departures =
                              DeparturesCubit.encode(departuresC.coloredDepartures);
                        var backed = bloc.backupSettings(backup);
                        backed.then((value) {
                          final snackBar = SnackBar(
                              content: Text('Backup finished successfully'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }).catchError((Object error) {
                          final snackBar = SnackBar(
                              content: Text('Error occured during backup'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      })),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: RaisedButton(
                    child: Text(
                      "RESTORE SETTINGS",
                    ),
                    onPressed: () async {
                      bloc.restoreSettings().then((backup) {
                        context.bloc<InstallationCubit>().restore(backup.airly);
                        context.bloc<StopsCubit>().restore(backup.stops);
                        context
                            .bloc<DeparturesCubit>()
                            .restore(backup.departures);
                        final snackBar = SnackBar(
                            content: Text('Restored settings successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }).catchError((Object error) {
                        final snackBar = SnackBar(
                            content:
                                Text('Error occured when restoring backup'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: RaisedButton(
                    child: Text(
                      "REMOVE BACKUP",
                    ),
                    onPressed: () async {
                      bloc.removeBackup().then((value) {
                        final snackBar = SnackBar(
                            content: Text('Backup removed successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }).catchError((Object error) {
                        final snackBar = SnackBar(
                            content:
                                Text('Error occured when removing backup'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                  )),
            ],
          );
        })
      ],
    );
  }
}
