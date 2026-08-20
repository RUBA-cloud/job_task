
import 'package:injectable/injectable.dart';
import 'package:job_task/domain/repository/shared_pref_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: SharedPrefsRepo)
class SharedPrefsRepoImp implements SharedPrefsRepo {
  final SharedPreferences _sharedPreferences;

  const SharedPrefsRepoImp(this._sharedPreferences);

  @override
  Future<void> savePref(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getPref(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> removePref(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> clearPrefs() async {
    await _sharedPreferences.clear();
  }
}