import 'package:injectable/injectable.dart';
import 'package:job_task/domain/repository/shared_pref_repo.dart';

@singleton
class GetPrefUseCase {
  final SharedPrefsRepo _repo;

  const GetPrefUseCase(this._repo);

  Future<String?> call(String key) {
    return _repo.getPref(key);
  }
}