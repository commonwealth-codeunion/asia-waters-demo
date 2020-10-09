import 'dart:async';

import 'package:asia_water/models/registry.dart';
import 'package:asia_water/service/registry_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registry_event.dart';
part 'registry_state.dart';

class RegistryBloc extends Bloc<RegistryEvent, RegistryState> {
  RegistryBloc() : super(RegistryInitial());
  RegistryService _registryService = RegistryService();

  @override
  Stream<RegistryState> mapEventToState(
    RegistryEvent event,
  ) async* {
    if (event is SendData) {
      yield Loading();
      try {
        await _registryService.uploadData(event.registry);
        yield Success();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
  }
}
