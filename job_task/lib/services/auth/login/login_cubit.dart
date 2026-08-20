import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/core/constants/shard_prefes_keys.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/di/location_service.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/request/auth_request/login_request.dart';
import 'package:job_task/data/model/response/auth_entity/login_entity.dart';
import 'package:job_task/domain/use_cases/auth/check_if_email_is_verifed_use_case.dart';
import 'package:job_task/domain/use_cases/auth/forgot_password_use_case.dart';
import 'package:job_task/domain/use_cases/auth/login_use_case.dart';
import 'package:job_task/domain/use_cases/shared_pref/get_shared_pref.dart';
import 'package:job_task/domain/use_cases/shared_pref/save_shared_pref.dart';
import 'package:job_task/services/auth/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // ============================================================
  // USE CASES
  // ============================================================

  final LoginUseCase loginUseCase = getIt<LoginUseCase>();

  final ForgotPasswordUseCase forgotPasswordUseCase =
  getIt<ForgotPasswordUseCase>();

  final CheckEmailVerifiedUseCase checkEmailVerifiedUseCase =
  getIt<CheckEmailVerifiedUseCase>();

  final SavePrefUseCase savePrefUseCase =
  getIt<SavePrefUseCase>();

  final GetPrefUseCase getPrefUseCase =
  getIt<GetPrefUseCase>();

  final LocationService locationService = LocationService();

  // ============================================================
  // GET CUBIT
  // ============================================================

  static LoginCubit get(BuildContext context) {
    return BlocProvider.of<LoginCubit>(context);
  }

  // ============================================================
  // LOGIN ENTITY
  // ============================================================

  LoginEntity? loginEntity;

  // ============================================================
  // CHECK IF USER IS ALREADY LOGGED IN
  // ============================================================

  Future<void> checkIfUserLoggedIn() async {
    try {
      debugPrint('Checking if user is already logged in...');

      // ========================================================
      // GET LOGIN STATUS
      // ========================================================

      final isLoggedIn = await getPrefUseCase.call(
        SharedPrefsKeys.isLoggedIn,
      );

      debugPrint('isLoggedIn = $isLoggedIn');

      // ========================================================
      // USER IS NOT LOGGED IN
      // ========================================================

      if (isLoggedIn != 'true') {
        loginEntity = null;

        emit( UserNoLoggedIn() );

        return;
      }

      // ========================================================
      // GET COMPLETE LOGIN ENTITY JSON
      // ========================================================

      final savedLoginEntity = await getPrefUseCase.call(
        SharedPrefsKeys.loginEntity,
      );

      debugPrint(
        'savedLoginEntity = $savedLoginEntity',
      );

      // ========================================================
      // CHECK IF LOGIN ENTITY EXISTS
      // ========================================================

      if (savedLoginEntity == null ||
          savedLoginEntity.toString().isEmpty) {
        debugPrint(
          'Login entity was not found in SharedPreferences',
        );

        // Data is incomplete, so clear login status
        await savePrefUseCase(
          key: SharedPrefsKeys.isLoggedIn,
          value: 'false',
        );

        loginEntity = null;

        emit(UserNoLoggedIn());

        return;
      }

      // ========================================================
      // JSON STRING -> MAP
      // ========================================================

      final Map<String, dynamic> json =
      jsonDecode(savedLoginEntity.toString());

      // ========================================================
      // MAP -> LOGIN ENTITY
      // ========================================================

      loginEntity = LoginEntity.fromJson(json);

      // ========================================================
      // USER IS ALREADY LOGGED IN
      // ========================================================

      emit(
        UserAlreadyLoggedIn(
          loginEntity!,
        ),
      );

      debugPrint(
        'User already logged in: ${loginEntity!.data.name}',
      );
    } catch (e, stackTrace) {
      debugPrint(
        'Check logged in error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      loginEntity = null;

      // If saved data is corrupted, treat user as logged out.
      emit(UserNoLoggedIn());
    }
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> submitLogin({
    required LoginRequest loginRequest,
  }) async {
    emit(LoginLoading());

    try {
      final result = await loginUseCase.execute(
        loginRequest,
      );

      switch (result) {
        case Success(:final data):

        // ====================================================
        // SAVE LOGIN ENTITY
        // ====================================================

          loginEntity = data;

          await saveUserLogin(
            loginEntity!,
          );

          break;

        case Failure(:final error):

        // ====================================================
        // EMAIL NOT VERIFIED
        // ====================================================

          if (result.statusCode == 403) {
            await checkEmailVerified(
              loginRequest: loginRequest,
            );

            return;
          }

          emit(
            LoginFailed(
              error?.message ?? 'Login failed',
            ),
          );

          break;
      }
    } catch (e, stackTrace) {
      debugPrint(
        'Login error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      emit(
        LoginFailed(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // SAVE LOGIN DATA
  // ============================================================

  Future<void> saveUserLogin(
      LoginEntity login,
      ) async {
    try {
      // ========================================================
      // LOGIN ENTITY -> JSON STRING
      // ========================================================

      final String loginJson = jsonEncode(
        login.toJson(),
      );

      debugPrint(
        'Saving login entity: $loginJson',
      );

      // ========================================================
      // SAVE COMPLETE LOGIN ENTITY
      // ========================================================

      await savePrefUseCase(
        key: SharedPrefsKeys.loginEntity,
        value: loginJson,
      );

      // ========================================================
      // SAVE LOGIN STATUS
      // ========================================================

      await savePrefUseCase(
        key: SharedPrefsKeys.isLoggedIn,
        value: 'true',
      );

      // ========================================================
      // SAVE INDIVIDUAL VALUES
      // ========================================================

      await Future.wait([
        savePrefUseCase(
          key: SharedPrefsKeys.userName,
          value: login.data.name,
        ),

        savePrefUseCase(
          key: SharedPrefsKeys.gallery,
          value: login.data.avatarPath?.toString() ?? '',
        ),

        savePrefUseCase(
          key: SharedPrefsKeys.email,
          value: login.data.email,
        ),

        savePrefUseCase(
          key: SharedPrefsKeys.phone,
          value: login.data.phone?.toString() ?? '',
        ),

        savePrefUseCase(
          key: SharedPrefsKeys.address,
          value: login.data.address?.toString() ?? '',
        ),

        savePrefUseCase(
          key: SharedPrefsKeys.token,
          value: login.data.accessToken,
        ),
      ]);

      // ========================================================
      // LOGIN SUCCESS
      // ========================================================

      emit(
        LoginSuccessful(login),
      );
    } catch (e, stackTrace) {
      debugPrint(
        'Save login data error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      emit(
        LoginFailed(
          'Failed to save login information',
        ),
      );
    }
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout() async {
    try {
      await savePrefUseCase(
        key: SharedPrefsKeys.isLoggedIn,
        value: 'false',
      );

      await savePrefUseCase(
        key: SharedPrefsKeys.loginEntity,
        value: '',
      );

      loginEntity = null;

      emit(UserNoLoggedIn());
    } catch (e) {
      debugPrint(
        'Logout error: $e',
      );
    }
  }

  // ============================================================
  // CHECK EMAIL VERIFIED
  // ============================================================

  Future<void> checkEmailVerified({
    required LoginRequest loginRequest,
  }) async {
    emit(
      CheckEmailVerifiedInitial(),
    );

    try {
      final result =
      await checkEmailVerifiedUseCase.execute(
        SendEmailRequest(
          email: loginRequest.email,
        ),
      );

      switch (result) {
        case Success(:final data):
          emit(
            CheckEmailVerifiedSuccessful(data),
          );
          break;

        case Failure():
          emit(
            CheckEmailVerifiedFailed(),
          );
          break;
      }
    } catch (e) {
      emit(
        CheckEmailVerifiedFailed(),
      );
    }
  }

  // ============================================================
  // PASSWORD VISIBILITY
  // ============================================================

  bool hidePassword = true;

  void changePasswordVisibility() {
    hidePassword = !hidePassword;

    emit(
      PasswordVisibilityChanged(
        hidePassword,
      ),
    );
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  Future<void> submitForgotPassword(
      SendEmailRequest forgotPasswordRequest,
      ) async {
    emit(
      ForgetPasswordLoading(),
    );

    try {
      final result =
      await forgotPasswordUseCase.execute(
        forgotPasswordRequest,
      );

      switch (result) {
        case Success(:final data):
          emit(
            ForgetPasswordLoaded(data),
          );
          break;

        case Failure():
          emit(
            ForgetPasswordFailed(
              result.error?.message ??
                  'Something went wrong',
            ),
          );
          break;
      }
    } catch (e) {
      emit(
        ForgetPasswordFailed(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void goToPassword() {
    emit(
      GoToForgetPassword(),
    );
  }

  void goToRegister() {
    emit(
      GoToRegister(),
    );
  }
}