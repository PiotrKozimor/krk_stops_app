import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/authentication_cubit.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/installation_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<AuthenticationCubit>();
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(12),
            child: Text(
              AppLocalizations.of(context)!.backup,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.apply(color: Theme.of(context).primaryColorDark),
            )),
        BlocBuilder<AuthenticationCubit, String>(builder: (context, state) {
          if (state == "") {
            return Column(children: [
              Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    AppLocalizations.of(context)!.loginPlease,
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context)!.login,
                    ),
                    onPressed: () async {
                      bloc.logIn();
                    },
                  )),
            ]);
          }
          var installationC = context.watch<InstallationCubit>();
          var stopsC = context.watch<StopsCubit>();
          var departuresC = context.watch<DeparturesCubit>();
          return Column(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    AppLocalizations.of(context)!.loginLoggedAs + " " + state,
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context)!.loginOut,
                    ),
                    onPressed: () async {
                      bloc.logOut();
                    },
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: ElevatedButton(
                      child: Text(
                        AppLocalizations.of(context)!.backupSettings,
                      ),
                      onPressed: () async {
                        var backup = Backup()
                          ..airly =
                              InstallationCubit.encode(installationC.state)
                          ..stops = StopsCubit.encode(stopsC.state)
                          ..departures = DeparturesCubit.encode(
                              departuresC.coloredDepartures);
                        var backed = bloc.backupSettings(backup);
                        backed.then((value) {
                          final snackBar = SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .backupSettingsOk));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }).catchError((Object error) {
                          final snackBar = SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .backupSettingsError));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      })),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context)!.backupRestore,
                    ),
                    onPressed: () async {
                      bloc.restoreSettings().then((backup) {
                        context.read<InstallationCubit>().restore(backup.airly);
                        context.read<StopsCubit>().restore(backup.stops);
                        context
                            .read<DeparturesCubit>()
                            .restore(backup.departures);
                        final snackBar = SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!.backupRestoreOk));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }).catchError((Object error) {
                        final snackBar = SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .backupRestoreError));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context)!.backupRemove,
                    ),
                    onPressed: () async {
                      bloc.removeBackup().then((value) {
                        final snackBar = SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!.backupRemoveOk));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }).catchError((Object error) {
                        final snackBar = SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .backupRemoveError));
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
