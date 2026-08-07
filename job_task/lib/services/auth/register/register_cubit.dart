import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/di/location_service.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/request/auth_request/register_request.dart';
import 'package:job_task/domain/use_cases/auth/register_use_case.dart';
import 'package:job_task/domain/use_cases/auth/verify_email_use_case.dart';
import 'package:job_task/services/auth/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  final RegisterUseCase registerUseCase = getIt<RegisterUseCase>();
  final VerifyEmailUseCase verifyEmailUseCase = getIt<VerifyEmailUseCase>();
  static RegisterCubit get(BuildContext context) =>
      BlocProvider.of<RegisterCubit>(context);
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  void changePasswordVisibility() {
    hidePassword = !hidePassword;
    emit(PasswordVisibilityChanged(hidePassword));
  }

  void changeConfirmPasswordVisibility() {
    hideConfirmPassword = !hideConfirmPassword;

    emit(ReenterPasswordVisibilityChanged(hideConfirmPassword));
  }
  String? country,city;
   void getLocation()async{
     final location = await LocationService().getCurrentLocation();
     country =location["country"];
     city =location["city"];
   }

  Future<void> register({required RegisterRequest request}) async {
    emit(RegisterLoadingState());

    final result = await registerUseCase.execute(request);
    switch (result) {
      case Success(:final data):
        emit(RegisterSuccessfulState(data));
        break;
      case Failure():
        final errorMessage =
            result.fieldError("email") ??
            result.fieldError("phone") ??
            result.error?.message ??
            'register failed';

        emit(RegisterFailedState(errorMessage));

        break;
    }
  }

  void goToVerifyEmail() {
    emit(GoToVerifyEmail());
  }
  Future<void> verifyEmail(String email) async {


    final result = await verifyEmailUseCase.execute(
      SendEmailRequest(email: email),
    );

    switch (result) {
      case Success(:final data):
        emit(VerifyEmailSuccessState(data));
        break;

      case Failure():
        emit(
          VerifyEmailFailedState(
            result.error?.message ??
                result.fieldError("email") ??
                "Failed to send verification email",
          ),
        );
        break;
    }
  }
}
