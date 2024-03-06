import 'package:flutter/material.dart';
import 'package:frontend/models/booking_model.dart';
import 'package:frontend/screens/booking/booking_list.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/models/user_modal.dart';

// class BookingConfirmationScreen extends StatelessWidget {
//   final Booking bookingDetails;

//   const BookingConfirmationScreen({super.key, required this.bookingDetails});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           // title: const Text('Booking Confirmed'),
//           ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Positioned(
//               top: 8,
//               right: 8,
//               child: Text(
//                 'Booking Confirmed',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Your booking has been confirmed. What would you like to do next?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18.0),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to payment screen
//               },
//               child: const Text('Proceed to Payment'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to view bookings screen
//               },
//               child: const Text('View Bookings'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//---------------------------------------------------------------------------------------------------------------------------

// class BookingConfirmationScreen extends StatelessWidget {
//   final Booking bookingDetails;

//   const BookingConfirmationScreen({Key? key, required this.bookingDetails})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.check_circle,
//               color: Colors.green,
//               size: 48.0,
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 16.0, top: 16.0),
//               child: Text(
//                 'Booking Confirmed!',
//                 style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Your booking has been confirmed. What would you like to do next?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18.0),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.green, // text color
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 32, vertical: 16), // button padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(24), // button border radius
//                 ),
//               ),
//               onPressed: () {},
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min, // use minimum size for the row
//                 children: [
//                   Icon(Icons.payment), // add payment icon
//                   SizedBox(width: 8), // add space between icon and text
//                   Text('Proceed to Payment'), // button text
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.blue, // text color
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 32, vertical: 16), // button padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(24), // button border radius
//                 ),
//               ),
//               onPressed: () {
//                 // Navigate to view bookings list screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const BookingList(),
//                   ),
//                 );
//               },
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min, // use minimum size for the row
//                 children: [
//                   Icon(Icons.calendar_today), // add calendar icon
//                   SizedBox(width: 8), // add space between icon and text
//                   Text('View Bookings'), // button text
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const AppNavBar(),
//     );
//   }
// }

// class ReviewBookingModal extends StatelessWidget {
//   final Map<String, dynamic> bookingDetails;

//   const ReviewBookingModal({Key? key, required this.bookingDetails});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: bookingDetails.entries.map((entry) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(entry.key),
//                   Text(entry.value.toString()),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       bottomNavigationBar: const AppNavBar(),
//     );
//   }
// }

class BookingConfirmationScreen extends StatelessWidget {
  final Booking bookingDetails;

  const BookingConfirmationScreen({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppDataStore.loggedInNotifier,
      builder: (context, isLoggedIn, _) {
        if (!isLoggedIn) {
          return const LoginSignupPage(
            dynamicModifierLoginSignupPage: 2,
          );
        } else {
          return BookingConfirmationContent(bookingDetails: bookingDetails);
        }
      },
    );
  }
}

class BookingConfirmationContent extends StatelessWidget {
  final Booking bookingDetails;

  const BookingConfirmationContent({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                'Booking Confirmed!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Your booking has been confirmed. What would you like to do next?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24), // button border radius
                ),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min, // use minimum size for the row
                children: [
                  Icon(Icons.payment), // add payment icon
                  SizedBox(width: 8), // add space between icon and text
                  Text('Proceed to Payment'), // button text
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24), // button border radius
                ),
              ),
              onPressed: () {
                // Navigate to view bookings list screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingList(),
                  ),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min, // use minimum size for the row
                children: [
                  Icon(Icons.calendar_today), // add calendar icon
                  SizedBox(width: 8), // add space between icon and text
                  Text('View Bookings'), // button text
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavBar(),
    );
  }
}
