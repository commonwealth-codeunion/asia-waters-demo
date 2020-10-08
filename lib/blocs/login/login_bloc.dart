import 'dart:async';

import 'package:asia_water/repository/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  final Api _api = Api();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LogIn) {
      try {
        yield Loading();
        // await _api.logIn(event.username, event.password);
        yield LoggedIn();
      } catch (e) {
        yield Failure(message: '$e');
      }
    }
  }
}
