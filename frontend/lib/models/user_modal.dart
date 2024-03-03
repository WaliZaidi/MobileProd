import '../models/venue_model.dart';
// ignore: library_prefixes
import '../models/booking_model.dart';

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

  factory UserInfo.empty() {
    return UserInfo(
      id: '',
      name: '',
      email: '',
      phone: '',
      address: '',
      date: '',
      time: '',
      service: '',
      status: '',
    );
  }
}

class BookedVenues {
  final List<Booking> listOfBookedVenues = [];
}

class FavoriteVenues {
  final List<Venue> favoriteVenues = [];
}
