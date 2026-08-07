abstract class SharedPrefsRepo {
  Future<void> savePref(String key, String value);

  Future<String?> getPref(String key);

  Future<void> removePref(String key);

  Future<void> clearPrefs();
}