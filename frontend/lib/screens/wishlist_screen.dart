import 'package:flutter/material.dart';
import 'package:frontend/models/venue_model.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import 'package:frontend/widgets/venue_card_widget.dart';
import 'package:frontend/widgets/wishlist_card_widget.dart';

// class WishListScreen extends StatefulWidget {
//   const WishListScreen({Key? key}) : super(key: key);

//   @override
//   State<WishListScreen> createState() => _WishListScreenState();
// }

// class _WishListScreenState extends State<WishListScreen> {
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
//                   buildWishList(context)
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

//   Widget buildLoginPrompt(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             const Text('Wishlist',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.bold,
//                 )),
//             const SizedBox(height: 20),
//             const Text(
//               'Log in to view your wishlist.',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.w400),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const LoginSignupPage(
//                       dynamicModifierLoginSignupPage: 2,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text('Log in'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildWishList(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0),
//       child: ListView(
//         children: [
//           const SizedBox(height: 40),
//           const Text('Wishlist',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.bold,
//               )),
//           const SizedBox(height: 10),
//           const Divider(
//             color: Color.fromARGB(255, 0, 0, 0),
//             thickness: 1,
//             indent: 10,
//             endIndent: 10,
//           ),
//           const SizedBox(height: 20),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 1,
//               childAspectRatio: 0.7,
//             ),
//             itemCount:
//                 AppDataStore.currentUser!.favoriteVenues.favoriteVenues.length,
//             itemBuilder: (context, index) {
//               return SizedBox(
//                 height: 300, // Set a specific height here
//                 child: VenueCardWidget(
//                   venue: AppDataStore
//                       .currentUser!.favoriteVenues.favoriteVenues[index],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late ValueNotifier<int> favoriteVenuesLengthNotifier;

  @override
  @override
  void initState() {
    super.initState();
    if (AppDataStore.currentUser != null) {
      favoriteVenuesLengthNotifier = ValueNotifier<int>(
          AppDataStore.currentUser!.favoriteVenues.favoriteVenues.length);
    } else {
      favoriteVenuesLengthNotifier = ValueNotifier<int>(0);
    }
  }

  @override
  void dispose() {
    favoriteVenuesLengthNotifier.dispose();
    super.dispose();
  }

  void updateWishlist() {
    setState(() {
      favoriteVenuesLengthNotifier.value =
          AppDataStore.currentUser!.favoriteVenues.favoriteVenues.length;
    });
  }

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
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
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
      ),
    );
  }

  Widget buildWishList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ValueListenableBuilder<int>(
        valueListenable: favoriteVenuesLengthNotifier,
        builder: (context, favoriteVenuesLength, _) {
          return ListView(
            children: [
              const SizedBox(height: 40),
              const Text('Wishlist',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              const Divider(
                color: Color.fromARGB(255, 0, 0, 0),
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(height: 20),
              CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 0.7,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final venue = AppDataStore
                            .currentUser!.favoriteVenues.favoriteVenues[index];
                        return SizedBox(
                            height: 300, // Set a specific height here
                            child: WishListCardWidget(
                              venue: venue,
                              onUpdateWishlist:
                                  updateWishlist, // Pass the updateWishlist function
                            ));
                      },
                      childCount: favoriteVenuesLength,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
