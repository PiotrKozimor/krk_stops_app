import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/authentication_cubit.dart';
import 'package:krk_stops_app/repository/firebase_repository.dart';
import 'package:krk_stops_app/view/backup_view.dart';
import 'package:krk_stops_app/view/legal_view.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text("KrkStops"),
        ),
        body: BlocProvider<AuthenticationCubit>(
            create: (_) => AuthenticationCubit(
                RepositoryProvider.of<FirebaseRepository>(context)),
            child: ListView(
              children: [
                BackupView(),
                Divider(
                  height: 7,
                  thickness: 1,
                ),
                LegalView(),
              ],
            )));

    return scaf;
  }
}
