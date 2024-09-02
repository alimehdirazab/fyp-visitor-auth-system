import 'package:hive/hive.dart';

part 'location_model.g.dart'; // This will be generated

@HiveType(typeId: 0)
class LocationModel extends HiveObject {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  int timestamp;

  @HiveField(3)
  String appointmentId;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.appointmentId,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
      };
}
