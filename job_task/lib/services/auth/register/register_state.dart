import 'package:job_task/data/model/response/auth_entity/verify_email_entity.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessfulState extends RegisterState {
  final dynamic data;

  RegisterSuccessfulState(this.data);
}

class RegisterFailedState extends RegisterState {
  final String error;

  RegisterFailedState(this.error);
}


class GoToLogin extends RegisterState {}
class GoToVerifyEmail extends RegisterState {}


class PasswordVisibilityChanged extends RegisterState {

  final bool hidePassword;

  PasswordVisibilityChanged(this.hidePassword);

}
class VerifyEmailLoadingState extends RegisterState {}

class VerifyEmailSuccessState extends RegisterState {
  final VerifyEmailEntity data;

  VerifyEmailSuccessState(this.data);
}

class VerifyEmailFailedState extends RegisterState {
  final String error;

  VerifyEmailFailedState(this.error);
}


class ReenterPasswordVisibilityChanged extends RegisterState {

  final bool hidePassword;

  ReenterPasswordVisibilityChanged(this.hidePassword);

}