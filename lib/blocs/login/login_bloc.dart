import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is StartVerification) {
      yield Loading();
      try {
        if (_firebaseAuth.currentUser != null) {
          yield LoggedIn();
        } else {
          yield LoginInitial();
        }
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
    if (event is LogIn) {
      yield Loading();
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        yield LoggedIn();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
    if (event is Register) {
      yield Loading();
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        yield LoggedIn();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
  }
}
