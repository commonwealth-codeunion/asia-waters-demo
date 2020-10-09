import 'package:cloud_firestore/cloud_firestore.dart';

class RegistryService {
  FirebaseFirestore _firestore;
  RegistryService() {
    _firestore = FirebaseFirestore.instance;
  }

  CollectionReference registryList(String documentId) {
    return _firestore.collection('registry');
  }
}
