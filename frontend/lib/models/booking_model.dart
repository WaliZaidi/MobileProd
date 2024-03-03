import 'package:frontend/models/user_modal.dart';
import 'package:frontend/models/venue_model.dart';

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
}
