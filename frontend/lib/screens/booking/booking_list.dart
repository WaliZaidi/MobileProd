// import 'package:flutter/material.dart';
// import 'package:frontend/store/store.dart';
// import 'package:frontend/theme/theme.dart';
// import 'package:frontend/widgets/app_nav_bar.dart';
// import 'package:frontend/widgets/top_app_bar.dart';

// class BookingList extends StatelessWidget {
//   const BookingList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: CustomTheme.theme,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Bookings'),
//           foregroundColor: Colors.red,
//         ),
//         body: Stack(
//           children: [
//             if (AppDataStore.currentUser?.name.isEmpty ?? true)
//               Positioned(
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Bookings',
//                       style: TextStyle(
//                           fontSize: 26,
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.w800),
//                     ),
//                     const Text(
//                       'Log in to view your bookings',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.w400),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/login');
//                       },
//                       child: const Text('Log in'),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               Positioned(
//                 child: Column(
//                   children: [
//                     const Text('Bookings'),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/booking');
//                       },
//                       child: const Text('Book a trip'),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//         bottomNavigationBar: const AppNavBar(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:frontend/store/store.dart';
// import 'package:frontend/theme/theme.dart';
// import 'package:frontend/widgets/app_nav_bar.dart';
// import 'package:frontend/widgets/top_app_bar.dart';

// class BookingList extends StatelessWidget {
//   const BookingList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: CustomTheme.theme,
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Stack(
//             children: [
//               if (AppDataStore.currentUser?.name.isEmpty ?? true)
//                 Positioned(
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                           height:
//                               140), // Add a space at the top of the page (140 pixels high
//                       const Text('Bookings',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.w600,
//                           )),
//                       const SizedBox(height: 140),
//                       const Text(
//                         'Log in to view your bookings',
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.w400),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/login');
//                         },
//                         child: const Text('Log in'),
//                       ),
//                     ],
//                   ),
//                 )
//               else
//                 Positioned(
//                   child: Column(
//                     children: [
//                       const Text('Bookings'),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/booking');
//                         },
//                         child: const Text('Book a trip'),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: const AppNavBar(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/app_nav_bar.dart';

class BookingList extends StatelessWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Stack(
            children: [
              if (AppDataStore.currentUser?.name.isEmpty ?? true)
                Positioned(
                  left: 16, // Adjust this value to position content to the left
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ), // Add a space at the top of the page (140 pixels high
                      const Text('Bookings',
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          )),
                      const Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      // const SizedBox(height: 140),
                      const Text(
                        'Log in to view your bookings.',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          MaterialPageRoute(
                            builder: (context) => const LoginSignupPage(),
                          );
                        },
                        child: const Text('Log in'),
                      ),
                    ],
                  ),
                )
              else
                Positioned(
                  left: 16, // Adjust this value to position content to the left
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ), // Add a space at the top of the page (140 pixels high
                      const Text('Bookings',
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          )),
                      const Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const Text('Bookings'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/booking');
                        },
                        child: const Text('Book a trip'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
