import 'package:geolocator/geolocator.dart';

class Registry {
  final String name;
  final String type;
  final Position position;

  Registry({this.name, this.type, this.position});
}
