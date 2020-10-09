part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  final bool isLoading = false;
}

class Failure extends LoginState {
  final bool isLoading = false;

  final String message;

  Failure({@required this.message});
}

class Success extends LoginState {
  final bool isLoading = false;
}

class LogedOut extends Success {}

class Loading extends LoginState {
  final bool isLoading = true;
}
