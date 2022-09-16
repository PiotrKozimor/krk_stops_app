import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/authentication_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/airly_cubit.dart';
import '../cubit/departures_cubit.dart';

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
              style: Theme.of(context).textTheme.headline6,
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
                          ..airly = AirlyCubit.encode(
                              context.read<AirlyCubit>().state.inst)
                          ..stops = StopsCubit.encode(
                              context.read<StopsCubit>().state)
                          ..departures = DeparturesCubit.encode(
                              context.read<DeparturesCubit>().colors);
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
                        context.read<AirlyCubit>().restore(backup.airly);
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
