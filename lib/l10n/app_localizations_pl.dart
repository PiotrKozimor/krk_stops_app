// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get loginLoggedAs => 'Zalogowany jako';

  @override
  String get loginOut => 'Wyloguj';

  @override
  String get login => 'Zaloguj';

  @override
  String get loginPlease => 'Zaloguj się aby utworzyć kopię zapasową';

  @override
  String get legalNotice => 'Nota prawna';

  @override
  String get backup => 'Kopia zapasowa';

  @override
  String get backupSettings => 'Zapisz ustawienia';

  @override
  String get backupSettingsOk => 'Pomyślnie zapisano ustawienia';

  @override
  String get backupSettingsError => 'Błąd podczas zapisu ustawień';

  @override
  String get backupRestore => 'Przywróc ustawienia';

  @override
  String get backupRestoreOk => 'Pomyślnie przywrócono ustawienia';

  @override
  String get backupRestoreError => 'Błąd podczas przywracania ustawień';

  @override
  String get backupRemove => 'Usuń kopię zapasową';

  @override
  String get backupRemoveOk => 'Pomyślnie usunięto kopię zapasową';

  @override
  String get backupRemoveError => 'Błąd podczas usuwania kopii zapasoweja';

  @override
  String get departuresError => 'Błąd podczas pobierania odjazdów';

  @override
  String get departuresErrorUpstream =>
      'Błąd zewnętrznego serwera podczas pobierania odjazdów';

  @override
  String get savedStopsAdd => 'Zapisz';

  @override
  String get savedStopsRemove => 'Usuń z zapisanych';

  @override
  String get stopsSearchError => 'Błąd podczas wyszukiwania przystanków';

  @override
  String get departureFilterbyType => 'Filtruj odjazdy autobusów lub tramwajów';
}
