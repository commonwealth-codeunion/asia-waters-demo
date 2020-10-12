part of 'registry_bloc.dart';

@immutable
abstract class RegistryState {}

class RegistryInitial extends RegistryState {}

class Loading extends RegistryState {}

class Failure extends RegistryState {
  final String message;

  Failure({@required this.message});
}

class Success extends RegistryState {}
