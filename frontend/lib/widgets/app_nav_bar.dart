// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../screens/wishlist_screen.dart';

// class AppNavBar extends StatelessWidget {
//   const AppNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 1.0,
//             spreadRadius: 1.0,
//             offset: const Offset(0.0, -1.0),
//           )
//         ],
//       ),
//       child: NavigationBarTheme(
//         data: NavigationBarThemeData(
//           labelTextStyle: MaterialStatePropertyAll(
//             Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
//           ),
//         ),
//         child: NavigationBar(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
//           onDestinationSelected: (int index) {},
//           indicatorColor: Colors.transparent,
//           selectedIndex: 0,
//           height: 56.0,
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Icons.search_outlined),
//               label: 'Explore',
//               selectedIcon: Icon(
//                 Icons.search,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.favorite_border_outlined),
//               label: 'Wishlist',
//               selectedIcon: Icon(
//                 Icons.favorite,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.wb_sunny_outlined),
//               label: 'Trips',
//               selectedIcon: Icon(
//                 Icons.wb_sunny,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.message_outlined),
//               label: 'Inbox',
//               selectedIcon: Icon(
//                 Icons.message,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.person_outline),
//               label: 'Log in',
//               selectedIcon: Icon(
//                 Icons.person,
//                 color: Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../screens/wishlist_screen.dart';

// class AppNavBar extends StatelessWidget {
//   const AppNavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 1.0,
//             spreadRadius: 1.0,
//             offset: const Offset(0.0, -1.0),
//           )
//         ],
//       ),
//       child: NavigationBarTheme(
//         data: NavigationBarThemeData(
//           labelTextStyle: MaterialStatePropertyAll(
//             Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
//           ),
//         ),
//         child: NavigationBar(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
//           onDestinationSelected: (int index) {
//             // Handle the Wishlist icon tap
//             if (index == 1) {
//               // Assuming Wishlist is at index 1
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const WishlistScreen()));
//             }
//           },
//           indicatorColor: Colors.transparent,
//           selectedIndex: 0,
//           height: 56.0,
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Icons.search_outlined),
//               label: 'Explore',
//               selectedIcon: Icon(
//                 Icons.search,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.favorite_border_outlined),
//               label: 'Wishlist',
//               selectedIcon: Icon(
//                 Icons.favorite,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.wb_sunny_outlined),
//               label: 'Trips',
//               selectedIcon: Icon(
//                 Icons.wb_sunny,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.message_outlined),
//               label: 'Inbox',
//               selectedIcon: Icon(
//                 Icons.message,
//                 color: Colors.red,
//               ),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.person_outline),
//               label: 'Log in',
//               selectedIcon: Icon(
//                 Icons.person,
//                 color: Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/wishlist_screen.dart';
import '../screens/booking_details_screen.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, -1.0),
          )
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
            Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (int index) {
            // Handle the tab taps
            switch (index) {
              case 0:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
                break;
              case 1:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WishListScreen()));
                break;
              case 2:
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BookingScreen()));
                break;
              // case 3:
              //   Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => LoginScreen()));
              //   break;
              default:
                break;
            }
          },
          indicatorColor: Colors.transparent,
          selectedIndex: 0,
          height: 56.0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: 'Explore',
              selectedIcon: Icon(
                Icons.search,
                color: Colors.red,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Wishlist',
              selectedIcon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                  Icons.calendar_today_outlined), // Adjusted icon for Bookings
              label: 'Bookings',
              selectedIcon: Icon(
                Icons.calendar_today,
                color: Colors.red,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Log in',
              selectedIcon: Icon(
                Icons.person,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
