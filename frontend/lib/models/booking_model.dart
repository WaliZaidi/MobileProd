import '../models/user_modal.dart';
import '../models/venue_model.dart';

class Booking {
  final UserInfo user;
  final String date;
  final String time;
  final Venue venue;
  final SubVenue subVenue;
  final int guestCount;
  final List<String> selectedOptions;
  final List<AvailableDate> selectedDates;
  final double totalAmount;
  final String status;

  Booking({
    required this.user,
    required this.date,
    required this.time,
    required this.venue,
    required this.subVenue,
    required this.guestCount,
    required this.selectedOptions,
    required this.selectedDates,
    required this.totalAmount,
    required this.status,
  });

  // Factory constructor to create an empty Booking object
  factory Booking.empty() {
    return Booking(
      user: UserInfo.empty(), // Use default constructor of UserInfo
      date: '',
      time: '',
      venue: Venue.empty(), // Use default constructor of Venue
      subVenue: SubVenue.empty(), // Use default constructor of SubVenue
      guestCount: 0,
      selectedOptions: [],
      selectedDates: [],
      totalAmount: 0.0,
      status: '',
    );
  }
}
