import 'package:flutter/material.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/store/store.dart';
import '../screens/home_screen.dart';
import '../screens/wishlist_screen.dart';
import '../screens/booking/booking_list.dart';

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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
                break;
              case 1:
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WishListScreen()));
                break;
              case 2:
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const BookingList()));
                break;
              case 3:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginSignupPage(
                          dynamicModifierLoginSignupPage: 1,
                        )));
                break;
              default:
                break;
            }
          },
          indicatorColor: Colors.transparent,
          selectedIndex: 0,
          height: 56.0,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: 'Explore',
              selectedIcon: Icon(
                Icons.search,
                color: Colors.red,
              ),
            ),
            const NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Wishlist',
              selectedIcon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            const NavigationDestination(
              icon: Icon(
                  Icons.calendar_today_outlined), // Adjusted icon for Bookings
              label: 'Bookings',
              selectedIcon: Icon(
                Icons.calendar_today,
                color: Colors.red,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              label: AppDataStore.loggedInUser == "true" ? 'Profile' : 'Login',
              selectedIcon: const Icon(
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
