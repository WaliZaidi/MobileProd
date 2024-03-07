// import 'package:flutter/material.dart';
// import 'package:frontend/screens/login_signup_screen.dart';
// import 'package:frontend/store/store.dart';
// import 'package:frontend/theme/theme.dart';
// import 'package:frontend/widgets/app_nav_bar.dart';
// import 'package:frontend/widgets/venue_card_widget.dart';
// import 'package:go_router/go_router.dart';

// class BookingList extends StatelessWidget {
//   const BookingList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: CustomTheme.theme,
//       child: Scaffold(
//         appBar: AppBar(),
//         body: ValueListenableBuilder<bool>(
//           valueListenable: AppDataStore.loggedInNotifier,
//           builder: (context, isLoggedIn, _) {
//             return Stack(
//               children: [
//                 if (isLoggedIn)
//                   buildBookingList(context)
//                 else
//                   buildLoginPrompt(context),
//               ],
//             );
//           },
//         ),
//         bottomNavigationBar: const AppNavBar(),
//       ),
//     );
//   }

//   Widget buildBookingList(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 40),
//           const Text(
//             'Bookings',
//             style: TextStyle(
//               fontSize: 26,
//               fontFamily: 'Montserrat',
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Divider(
//             color: Color.fromARGB(255, 0, 0, 0),
//             thickness: 1,
//             indent: 10,
//             endIndent: 10,
//           ),
//           const SizedBox(height: 20),
//           Stack(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: AppDataStore
//                     .currentUser!.bookedVenues.listOfBookedVenues.length,
//                 itemBuilder: (context, index) {
//                   return VenueCardWidget(
//                     venue: AppDataStore.currentUser!.bookedVenues
//                         .listOfBookedVenues[index].venue,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildLoginPrompt(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 40),
//           const Text('Bookings',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.bold,
//               )),
//           const SizedBox(height: 20),
//           const Text(
//             'Log in to view your bookings.',
//             style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const LoginSignupPage(
//                     dynamicModifierLoginSignupPage: 2,
//                   ),
//                 ),
//               );
//             },
//             child: const Text('Log in'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import 'package:frontend/widgets/booking_card_widget.dart';
import 'package:frontend/widgets/venue_card_widget.dart';
import 'package:go_router/go_router.dart';

class BookingList extends StatelessWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: AppBar(),
        body: ValueListenableBuilder<bool>(
          valueListenable: AppDataStore.loggedInNotifier,
          builder: (context, isLoggedIn, _) {
            return isLoggedIn
                ? buildBookingList(context)
                : buildLoginPrompt(context);
          },
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }

  Widget buildBookingList(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Bookings',
              style: TextStyle(
                fontSize: 26,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 0, 0, 0),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppDataStore
                    .currentUser!.bookedVenues.listOfBookedVenues.length,
                itemBuilder: (context, index) {
                  return BookingListCardWidget(
                    venue: AppDataStore.currentUser!.bookedVenues
                        .listOfBookedVenues[index].venue,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginPrompt(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text('Bookings',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            const Text(
              'Log in to view your bookings.',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginSignupPage(
                        dynamicModifierLoginSignupPage: 2,
                      ),
                    ),
                  );
                },
                child: const Text('Log in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
