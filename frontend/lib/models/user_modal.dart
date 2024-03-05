import '../models/venue_model.dart';
// ignore: library_prefixes
import '../models/booking_model.dart';

class UserInfo {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String date;
  final String password;
  final String confirmPassword;
  final String cnic;
  final String time;
  final String status;
  final BookedVenues bookedVenues = BookedVenues();
  final FavoriteVenues favoriteVenues = FavoriteVenues();

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.date,
    required this.time,
    required this.status,
    required this.password,
    required this.confirmPassword,
    required this.cnic,
  });

  factory UserInfo.empty() {
    return UserInfo(
      id: '',
      name: '',
      email: '',
      phone: '',
      date: '',
      time: '',
      status: '',
      password: '',
      confirmPassword: '',
      cnic: '',
    );
  }

  UserInfo copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? date,
    String? time,
    String? status,
    String? password,
    String? confirmPassword,
    String? cnic,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      cnic: cnic ?? this.cnic,
    );
  }
}

class BookedVenues {
  final List<Booking> listOfBookedVenues = [];
}

class FavoriteVenues {
  final List<Venue> favoriteVenues = [];
}
