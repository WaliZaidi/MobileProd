import 'package:flutter/material.dart';
import 'package:frontend/models/booking_model.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Booking bookingDetails;

  const BookingConfirmationScreen({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Your booking has been confirmed. What would you like to do next?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to payment screen
              },
              child: const Text('Proceed to Payment'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to view bookings screen
              },
              child: const Text('View Bookings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewBookingModal extends StatelessWidget {
  final Map<String, dynamic> bookingDetails;

  const ReviewBookingModal({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bookingDetails.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value.toString()),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
