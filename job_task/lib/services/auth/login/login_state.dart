import 'package:job_task/data/model/response/auth_entity/check_email_verified_entity.dart';
import 'package:job_task/data/model/response/auth_entity/forgot_password_entity.dart';
import 'package:job_task/data/model/response/auth_entity/login_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class GoToRegister extends LoginState {}

class GoToForgetPassword extends LoginState {}

class LoginSuccessful extends LoginState {
  final LoginEntity loginEntity;

  LoginSuccessful(this.loginEntity);
}

class LoginFailed extends LoginState {
  final String? error;

  LoginFailed(this.error);
}


/// Check Email Verified
class CheckEmailVerifiedSuccessful extends LoginState {
  final CheckEmailVerifiedEntity checkEmailVerifiedEntity;

  CheckEmailVerifiedSuccessful(this.checkEmailVerifiedEntity);
}
class CheckEmailVerifiedLoading extends LoginState {

}
class CheckEmailVerifiedInitial extends LoginState {

}
class CheckEmailVerifiedFailed extends LoginState {

  CheckEmailVerifiedFailed();
}


/// Password Visibility
class PasswordVisibilityChanged extends LoginState {
  final bool hidePassword;

  PasswordVisibilityChanged(this.hidePassword);
}


/// Forgot Password
class ForgetPasswordInitial extends LoginState {}

class ForgetPasswordLoading extends LoginState {}

class ForgetPasswordFailed extends LoginState {
  final String error;

  ForgetPasswordFailed(this.error);
}

class ForgetPasswordLoaded extends LoginState {
  final ForgotPasswordEntity passwordEntity;

  ForgetPasswordLoaded(this.passwordEntity);
}