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
import 'package:job_task/domain/use_cases/shared_pref/save_shared_pref.dart';
import 'package:job_task/services/auth/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LoginUseCase loginUseCase = getIt<LoginUseCase>();

  final ForgotPasswordUseCase forgotPasswordUseCase =
  getIt<ForgotPasswordUseCase>();

  final CheckEmailVerifiedUseCase checkEmailVerifiedUseCase =
  getIt<CheckEmailVerifiedUseCase>();

  final SavePrefUseCase savePrefUseCase =
  getIt<SavePrefUseCase>();

  final LocationService locationService = LocationService();

  static LoginCubit get(BuildContext context) =>
      BlocProvider.of<LoginCubit>(context);

  LoginEntity? loginEntity;

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> submitLogin({
    required LoginRequest loginRequest,
  }) async {
    emit(LoginLoading());

    final result = await loginUseCase.execute(loginRequest);

    switch (result) {
      case Success(:final data):
        loginEntity = data;

        // IMPORTANT:
        // Wait until token is saved before continuing.
        await saveUserLogin(loginEntity!);

        break;

      case Failure(:final error):
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
  }

  // ============================================================
  // SAVE LOGIN DATA
  // ============================================================

  Future<void> saveUserLogin(LoginEntity login) async {
    try {
    // final location = await locationService.getCurrentLocation();

      await savePrefUseCase(
        key: SharedPrefs.userName,
        value: login.data.name,
      );

    // rer
      await savePrefUseCase(
        key: SharedPrefs.email,
        value: login.data.email,
      );

      // Access token
      await savePrefUseCase(
        key: SharedPrefs.token,
        value: login.data.accessToken,
      );


      //
      // await savePrefUseCase(
      //   key: SharedPrefs.country,
      //   value: location['country'] ?? '',
      // );
      //
      // await savePrefUseCase(
      //   key: SharedPrefs.city,
      //   value: location['city'] ?? '',
      // );
      //
      // await savePrefUseCase(
      //   key: SharedPrefs.latitude,
      //   value: location['latitude'].toString(),
      // );



      emit(LoginSuccessful(login));
    } catch (e) {
      debugPrint('Save login data error: $e');

      emit(
        LoginFailed('Failed to save login information'),
      );
    }
  }
  // ============================================================
  // CHECK EMAIL VERIFIED
  // ============================================================

  Future<void> checkEmailVerified({
    required LoginRequest loginRequest,
  }) async {
    emit(CheckEmailVerifiedInitial());

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
  }

  // ============================================================
  // PASSWORD VISIBILITY
  // ============================================================

  bool hidePassword = true;

  void changePasswordVisibility() {
    hidePassword = !hidePassword;

    emit(
      PasswordVisibilityChanged(hidePassword),
    );
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  Future<void> submitForgotPassword(
      SendEmailRequest forgotPasswordRequest,
      ) async {
    emit(ForgetPasswordLoading());

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
          LoginFailed(
            result.error?.message ?? 'Something went wrong',
          ),
        );
        break;
    }
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void goToPassword() {
    emit(GoToForgetPassword());
  }

  void goToRegister() {
    emit(GoToRegister());
  }
}