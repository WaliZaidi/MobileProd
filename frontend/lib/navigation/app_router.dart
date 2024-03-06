import 'package:frontend/screens/booking/booking_list.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/screens/wishlist_screen.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: '/bookingsList',
          builder: (context, state) => const BookingList()),
      GoRoute(
          path: '/login',
          builder: (context, state) =>
              const LoginSignupPage(dynamicModifierLoginSignupPage: 1)),
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishListScreen(),
      )
    ],
  );
}
