import 'package:asia_water/models/registry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistryService {
  FirebaseFirestore _firestore;
  FirebaseAuth _firebaseAuth;
  RegistryService() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
  }

  CollectionReference registryList(String documentId) {
    return _firestore.collection('registry');
  }

  Stream<QuerySnapshot> getData() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .collection('registry_audits')
        .snapshots();
  }

  Future<void> uploadData(Registry registry) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .collection('registry_audits')
        .add(
      {
        'date': DateTime.now(),
        'name': registry.name,
        'type': registry.type,
        'position':
            "${registry.position.latitude} ${registry.position.longitude}",
      },
    );
  }
}
