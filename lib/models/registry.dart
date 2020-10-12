import 'package:geolocator/geolocator.dart';

class Registry {
  final String name;
  final String type;
  final Position position;
  final String uid;

  Registry({
    this.name,
    this.type,
    this.position,
    this.uid,
  });
}
