import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/authentication_cubit.dart';
import 'package:krk_stops_app/repository/firebase_repository.dart';
import 'package:krk_stops_app/view/backup_view.dart';
import 'package:krk_stops_app/view/installation_view.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text("KrkStops"),
        ),
        body:
            // RepositoryProvider<FirebaseRepository>(
            //     create: (context) => FirebaseRepository(),
            // child:
            BlocProvider<AuthenticationCubit>(
                create: (_) => AuthenticationCubit(
                    RepositoryProvider.of<FirebaseRepository>(context)),
                child: ListView(
                  children: [
                    InstallationView(),
                    Divider(
                      height: 7,
                      thickness: 1,
                    ),
                    BackupView()
                  ],
                ))
        // )
        );
    return scaf;
  }
}
