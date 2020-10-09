part of 'registry_bloc.dart';

@immutable
abstract class RegistryEvent {}

class SendData extends RegistryEvent {
  final Registry registry;

  SendData(this.registry);
}
