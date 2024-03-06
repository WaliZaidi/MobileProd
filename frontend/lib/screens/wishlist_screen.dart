import 'package:flutter/material.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import 'package:frontend/widgets/venue_card_widget.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: AppBar(),
        body: ValueListenableBuilder<bool>(
          valueListenable: AppDataStore.loggedInNotifier,
          builder: (context, isLoggedIn, _) {
            return Stack(
              children: [
                if (isLoggedIn)
                  buildWishList(context)
                else
                  buildLoginPrompt(context),
              ],
            );
          },
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }

  Widget buildLoginPrompt(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text('Wishlist',
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
          const SizedBox(height: 20),
          const Text(
            'Log in to view your wishlist.',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
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
        ],
      ),
    );
  }

  Widget buildWishList(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        const Text('Wishlist',
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
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount:
              AppDataStore.currentUser!.favoriteVenues.favoriteVenues.length,
          itemBuilder: (context, index) {
            return VenueCardWidget(
              venue: AppDataStore
                  .currentUser!.favoriteVenues.favoriteVenues[index],
            );
          },
        ),
      ],
    );
  }
}
