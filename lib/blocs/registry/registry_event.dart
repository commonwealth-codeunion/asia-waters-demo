part of 'registry_bloc.dart';

@immutable
abstract class RegistryEvent {}

class SendData extends RegistryEvent {
  final Registry registry;
  final File image;

  SendData(this.registry, this.image);
}
