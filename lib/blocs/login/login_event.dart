part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LogIn extends LoginEvent {
  final String email;
  final String password;

  LogIn({@required this.email, @required this.password});
}

class Register extends LoginEvent {
  final String email;
  final String password;

  Register({@required this.email, @required this.password});
}

class StartVerification extends LoginEvent {}
