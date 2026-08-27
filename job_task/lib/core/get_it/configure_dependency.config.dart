// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:job_task/core/di/network_module.dart' as _i722;
import 'package:job_task/core/get_it/configure_dependency.dart' as _i813;
import 'package:job_task/data/api_service/api_service.dart' as _i812;
import 'package:job_task/data/repository/auth_repo_imp.dart' as _i1039;
import 'package:job_task/data/repository/home_page_drawer_repo_imp.dart'
    as _i732;
import 'package:job_task/data/repository/home_page_repo_imp.dart' as _i669;
import 'package:job_task/data/repository/shared_pref_imp.dart' as _i513;
import 'package:job_task/domain/repository/auth_repo.dart' as _i352;
import 'package:job_task/domain/repository/home_page_drawer_repo.dart' as _i470;
import 'package:job_task/domain/repository/home_page_repo.dart' as _i10;
import 'package:job_task/domain/repository/shared_pref_repo.dart' as _i788;
import 'package:job_task/domain/use_cases/about_us/about_us_use_case.dart'
    as _i860;
import 'package:job_task/domain/use_cases/auth/check_if_email_is_verifed_use_case.dart'
    as _i635;
import 'package:job_task/domain/use_cases/auth/forgot_password_use_case.dart'
    as _i1055;
import 'package:job_task/domain/use_cases/auth/login_use_case.dart' as _i955;
import 'package:job_task/domain/use_cases/auth/register_use_case.dart' as _i139;
import 'package:job_task/domain/use_cases/auth/update_profile_use_case.dart'
    as _i752;
import 'package:job_task/domain/use_cases/auth/verify_email_use_case.dart'
    as _i238;
import 'package:job_task/domain/use_cases/cart/add_cart_to_product_use_case.dart'
    as _i78;
import 'package:job_task/domain/use_cases/cart/get_cart_use_case.dart' as _i634;
import 'package:job_task/domain/use_cases/cart/remove_product_from_cart_use_case.dart'
    as _i446;
import 'package:job_task/domain/use_cases/cart/update_cart_item_use_case.dart'
    as _i867;
import 'package:job_task/domain/use_cases/faviorate/add_product_fav_use_case.dart'
    as _i768;
import 'package:job_task/domain/use_cases/faviorate/get_fav_use_case.dart'
    as _i622;
import 'package:job_task/domain/use_cases/faviorate/remove_product_from_fav_use_case.dart'
    as _i819;
import 'package:job_task/domain/use_cases/get_product_use_case.dart' as _i663;
import 'package:job_task/domain/use_cases/our_branches_use_case.dart' as _i491;
import 'package:job_task/domain/use_cases/shared_pref/get_shared_pref.dart'
    as _i535;
import 'package:job_task/domain/use_cases/shared_pref/remove_shared_pef_use_case.dart'
    as _i508;
import 'package:job_task/domain/use_cases/shared_pref/save_shared_pref.dart'
    as _i576;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.singleton<_i812.ApiService>(() => _i812.ApiService(gh<_i361.Dio>()));
    gh.factory<_i470.HomePageDrawerRepo>(
      () => _i732.HomePageDrawerRepoImp(gh<_i812.ApiService>()),
    );
    gh.factory<_i10.HomePageRepo>(
      () => _i669.HomePageRepoImp(gh<_i812.ApiService>()),
    );
    gh.singleton<_i78.AddCartToProductUseCase>(
      () => _i78.AddCartToProductUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i634.GetCartUseCase>(
      () => _i634.GetCartUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i446.RemoveCartItemUseCase>(
      () => _i446.RemoveCartItemUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i867.UpdateCartItemUseCase>(
      () => _i867.UpdateCartItemUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i768.AddProductToFavUseCase>(
      () => _i768.AddProductToFavUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i622.GetFavUseCase>(
      () => _i622.GetFavUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i819.RemoveProductFromFavUseCase>(
      () => _i819.RemoveProductFromFavUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.singleton<_i663.GetProductUseCase>(
      () => _i663.GetProductUseCase(gh<_i10.HomePageRepo>()),
    );
    gh.factory<_i788.SharedPrefsRepo>(
      () => _i513.SharedPrefsRepoImp(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i860.AboutUsUseCase>(
      () => _i860.AboutUsUseCase(gh<_i470.HomePageDrawerRepo>()),
    );
    gh.singleton<_i491.OurBranchUseCase>(
      () => _i491.OurBranchUseCase(gh<_i470.HomePageDrawerRepo>()),
    );
    gh.factory<_i352.AuthRepo>(
      () => _i1039.AuthRepoImp(gh<_i812.ApiService>()),
    );
    gh.singleton<_i535.GetPrefUseCase>(
      () => _i535.GetPrefUseCase(gh<_i788.SharedPrefsRepo>()),
    );
    gh.singleton<_i508.RemovePrefUseCase>(
      () => _i508.RemovePrefUseCase(gh<_i788.SharedPrefsRepo>()),
    );
    gh.singleton<_i576.SavePrefUseCase>(
      () => _i576.SavePrefUseCase(gh<_i788.SharedPrefsRepo>()),
    );
    gh.singleton<_i1055.ForgotPasswordUseCase>(
      () => _i1055.ForgotPasswordUseCase(gh<_i352.AuthRepo>()),
    );
    gh.singleton<_i955.LoginUseCase>(
      () => _i955.LoginUseCase(gh<_i352.AuthRepo>()),
    );
    gh.singleton<_i139.RegisterUseCase>(
      () => _i139.RegisterUseCase(gh<_i352.AuthRepo>()),
    );
    gh.singleton<_i752.UpdateProfileUseCase>(
      () => _i752.UpdateProfileUseCase(gh<_i352.AuthRepo>()),
    );
    gh.singleton<_i238.VerifyEmailUseCase>(
      () => _i238.VerifyEmailUseCase(gh<_i352.AuthRepo>()),
    );
    gh.factory<_i635.CheckEmailVerifiedUseCase>(
      () => _i635.CheckEmailVerifiedUseCase(gh<_i352.AuthRepo>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i813.SharedPreferencesModule {}

class _$NetworkModule extends _i722.NetworkModule {}
