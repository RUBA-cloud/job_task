import 'package:injectable/injectable.dart';
import 'package:job_task/domain/repository/shared_pref_repo.dart';


@singleton
class RemovePrefUseCase {
  final SharedPrefsRepo _repo;

  const RemovePrefUseCase(this._repo);

  Future<void> call() {
    return _repo.clearPrefs();
  }
}