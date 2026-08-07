
import 'package:injectable/injectable.dart';

import 'package:job_task/domain/repository/shared_pref_repo.dart';

@singleton

class SavePrefUseCase {
  final  SharedPrefsRepo  _repo;

  const SavePrefUseCase(this._repo);

  Future<void> call({
    required String key,
    required String value,
  }) {
    return _repo.savePref(key, value);
  }
}