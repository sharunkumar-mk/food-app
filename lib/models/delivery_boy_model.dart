import 'package:cloud_firestore/cloud_firestore.dart';

DeliveryBoy deliveryBoyFormJson(str) {
  return DeliveryBoy.fromJson(str);
}

class DeliveryBoy {
  final String id;
  final String name;
  final String phoneNumber;
  final GeoPoint geoPoint;
  final double latitude;
  final double longitude;

  DeliveryBoy(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.latitude,
      required this.longitude,
      required this.geoPoint});

  factory DeliveryBoy.fromJson(Map<String, dynamic> json) {
    return DeliveryBoy(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        geoPoint: json['geoPoint']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'geoPoint': geoPoint
    };
  }
}
