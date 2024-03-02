import '../models/venue_model.dart';

class UserInfo {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String date;
  final String time;
  final String service;
  final String status;
  final BookedVenues bookedVenues = BookedVenues();
  final FavoriteVenues favoriteVenues = FavoriteVenues();

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.date,
    required this.time,
    required this.service,
    required this.status,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      date: json['date'],
      time: json['time'],
      service: json['service'],
      status: json['status'],
    );
  }
}

class BookedVenues {
  final List<Venue> bookedVenues = [];
}

class FavoriteVenues {
  final List<Venue> favoriteVenues = [];
}

