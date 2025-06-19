// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginLoggedAs => 'Logged as';

  @override
  String get loginOut => 'Log out';

  @override
  String get login => 'Log in';

  @override
  String get loginPlease => 'Please log in to backup settings';

  @override
  String get legalNotice => 'Legal notice';

  @override
  String get backup => 'Cloud backup';

  @override
  String get backupSettings => 'Backup Settings';

  @override
  String get backupSettingsOk => 'Backup finished successfully';

  @override
  String get backupSettingsError => 'Error occured during backup';

  @override
  String get backupRestore => 'Restore Settings';

  @override
  String get backupRestoreOk => 'Restored settings successfully';

  @override
  String get backupRestoreError => 'Error occured when restoring backup';

  @override
  String get backupRemove => 'Remove Backup';

  @override
  String get backupRemoveOk => 'Backup removed successfully';

  @override
  String get backupRemoveError => 'Error occured when removing backup';

  @override
  String get departuresError => 'Failed to fetch departures';

  @override
  String get departuresErrorUpstream =>
      'Failed to fetch departures: upstream server error';

  @override
  String get savedStopsAdd => 'Add to saved';

  @override
  String get savedStopsRemove => 'Remove from saved';

  @override
  String get stopsSearchError => 'Failed to search stops';

  @override
  String get departureFilterbyType => 'Filter bus or tram departures';
}
