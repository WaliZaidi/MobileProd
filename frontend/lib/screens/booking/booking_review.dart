import 'package:flutter/material.dart';
import 'package:frontend/models/booking_model.dart';
import 'package:frontend/models/user_modal.dart';
import 'package:frontend/models/venue_model.dart';
import 'package:frontend/theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BookingReviewScreen extends StatelessWidget {
  final Booking booking;

  const BookingReviewScreen({Key? key, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Booking Review'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Venue Image Carousel
              Container(
                height: 200, // Set a fixed height for the carousel
                child: CarouselSlider(
                  items: booking.venue.images.expand((imageUrl) {
                    return imageUrl.toImageList().map((imageLink) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(imageLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9, // Set the aspect ratio as needed
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    pauseAutoPlayOnManualNavigate: true,
                  ),
                ),
              ),
              // Booking Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Date: ${booking.date}'),
                    Text('Time: ${booking.time}'),
                    Text('Guest Count: ${booking.guestCount}'),
                    Text('Total Amount: ${booking.totalAmount}'),
                  ],
                ),
              ),
              // User Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Info',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Name: ${booking.user.name}'),
                    Text('Email: ${booking.user.email}'),
                    Text('Phone: ${booking.user.phone}'),
                  ],
                ),
              ),
              // Venue Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Venue Info',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Name: ${booking.venue.nameOfVenue}'),
                    Text('Location: ${booking.venue.locationOfVenue}'),
                    Text('Rating: ${booking.venue.rating}'),
                  ],
                ),
              ),
              // Sub Venue Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sub Venue Info',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Name: ${booking.subVenue.nameOfSubVenue}'),
                    Text('Capacity: ${booking.subVenue.capacityOfSubVenue}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
