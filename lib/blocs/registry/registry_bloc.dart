import 'dart:async';
import 'dart:io';

import 'package:asia_water/models/registry.dart';
import 'package:asia_water/service/registry_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as Path;

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
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child('audits/${Path.basename(event.image.path)}}');
        StorageUploadTask uploadTask = storageReference.putFile(event.image);
        await uploadTask.onComplete;
        print('File Uploaded');
        // storageReference.getDownloadURL().then((fileURL) {});

        yield Success();
      } catch (e) {
        yield Failure(message: e.toString());
      }
    }
  }
}
