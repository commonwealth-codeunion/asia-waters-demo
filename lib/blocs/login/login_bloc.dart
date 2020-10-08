import 'dart:async';

import 'package:asia_water/service/login_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  LoginService _loginService = LoginService();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is StartVerification) {
      yield Loading();
      try {
        if (_loginService.isSignedIn()) {
          yield Success();
        } else {
          yield LoginInitial();
        }
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
    if (event is LogOut) {
      yield Loading();
      try {
        await _loginService.logOut();
        yield LogedOut();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
    if (event is LogIn) {
      yield Loading();
      try {
        await _loginService.signIn(event.email, event.password);
        yield Success();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
    if (event is Register) {
      yield Loading();
      try {
        await _loginService.register(event.email, event.password);
        yield Success();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
  }
}
