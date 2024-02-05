import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      // GoRoute(
      //   path: '/booking-details',
      //   pageBuilder: (context, state) => const BookingDetailsScreen(),
      // ),
    ],
  );
}
