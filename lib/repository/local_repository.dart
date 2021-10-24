import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  final preferencesLoaded = Completer<void>();
  late SharedPreferences preferences;
  LocalRepository() {
    SharedPreferences.getInstance().then((value) {
      this.preferences = value;
      this.preferencesLoaded.complete();
    });
  }
}
