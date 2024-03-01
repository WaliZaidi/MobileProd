import 'package:flutter/material.dart';
import 'package:frontend/store/store.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart'; // Import the Venue model

class UserBookingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
      ),
      body: ListView.builder(
        itemCount: user.bookedVenues.bookedVenues.length,
        itemBuilder: (context, index) {
          Venue bookedVenue = user.bookedVenues.bookedVenues[index];
          return ListTile(
            title: Text(bookedVenue.name),
            subtitle: Text('Booking Date: ${user.date}'),
            // Add more details as needed
          );
        },
      ),
    );
  }
}
