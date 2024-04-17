import 'package:flutter/material.dart';
import 'package:frontend/screens/wishlist_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import '../models/venue_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/theme.dart';
import 'booking/booking_details_screen.dart';
import '../widgets/loader_bars.dart';
// import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
// import '../screens/ar_view_screen.dart';

class VenueDetailsScreen extends StatelessWidget {
  final Venue venue;

  const VenueDetailsScreen({Key? key, required this.venue}) : super(key: key);

  // void _launchApp() {
  //   AndroidIntent intent = const AndroidIntent(
  //     action: 'android.intent.action.MAIN',
  //     package:
  //         "com.Festivo.Festivo_unity_AR", // Replace with the package name of the installed app
  //   );
  //   intent.launch();
  // }

  void _launchApp() {
    try {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.MAIN',
        package:
            "com.Festivo.Festivo_unity_AR", // Replace with the package name of the installed app
      );
      intent.launch();
    } catch (e) {
      print("Error launching the app: $e");
    }
  }

  // void _launchApp() {
  //   AndroidIntent intent = const AndroidIntent(
  //     action: 'android.intent.action.MAIN',
  //     package:
  //         "com.Festivo.Festivo_unity_AR", // Replace with the package name of the installed app
  //   );
  //   intent.launch();
  // }

  // void _launchApp() async {
  //   const String urlScheme =
  //       'com.Festivo.Festivo_unity_AR'; // Replace with the URL scheme of the app you want to launch
  //   if (await canLaunch(urlScheme)) {
  //     await launch(urlScheme);
  //   } else {
  //     throw 'Could not launch $urlScheme';
  //   }
  // }

  Widget buildCarouselSlider(Venue venue) {
    return CarouselSlider(
      items: venue.images.expand((imageUrl) {
        return imageUrl.toImageList().map((imageLink) {
          try {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.network(
                imageLink,
                fit: BoxFit.cover,
              ),
            );
          } on Exception catch (e) {
            print('Error loading image: $e');
            return const Center(
              child: Text('Error loading image'),
            );
          }
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          // title: const Text('Venue Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                AppDataStore.isVenueFavorite(venue)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: AppDataStore.isVenueFavorite(venue) ? Colors.red : null,
              ),
              onPressed: () {
                if (AppDataStore.loggedInNotifier.value == false) {
                  LoaderBar.showMessage(
                      context, "Please login to add to favourites!");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishListScreen(),
                    ),
                  );
                  return;
                } else {
                  if (AppDataStore.isVenueFavorite(venue)) {
                    LoaderBar.showMessage(
                        context, "Venue removed from favourites!");
                    AppDataStore.removeFavouriteVenue(venue);
                  } else {
                    LoaderBar.showMessage(
                        context, "Venue added to favourites!");
                    AppDataStore.addFavouriteVenue(venue);
                  }
                  AppDataStore.updateVenueFavouriteStatus(venue);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Image Carousel
            Container(
              height: 200, // Set a fixed height for the carousel
              child: buildCarouselSlider(venue),
            ),
            // Rest of the content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                    top: 16), // Adjust top padding to match carousel height
                children: [
                  // Venue Name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      venue.nameOfVenue,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  // Location of Venue
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      venue.locationOfVenue,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  // Other Information
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: Text(
                      'Rating: ${venue.rating}   |   ${venue.reviews.isEmpty ? venue.reviews.length : venue.numberOfReviews} Reviews',
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Reviews'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: venue.reviews.isEmpty
                                    ? [
                                        const Text('No reviews available!'),
                                      ]
                                    : venue.reviews.map((review) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Divider(),
                                            Text(
                                              '${review.stars} ⭐',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Review: ${review.text == 'null' ? '-' : review.text}',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(
                        'Total Halls Capacity: ${venue.totalHallsCapacity}'),
                  ),
                  // Available Dates
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Available Dates'),
                    subtitle: const Text(
                      'Click to view available dates',
                      style: TextStyle(fontSize: 10),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 300.0, // Set the height as needed
                            child: ListView.builder(
                              itemCount: venue.subVenues.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      venue.subVenues[index].nameOfSubVenue,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Capacity: ${venue.subVenues[index].capacityOfSubVenue}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Available Dates'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: venue
                                                      .subVenues[index]
                                                      .availableDates
                                                      .map((date) => Text(
                                                            'Date: ${date.date.day}/${date.date.month}/${date.date.year} \nStart Time: ${date.startTime} \nEnd Time: ${date.endTime}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Click to view available dates',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            color: Color.fromARGB(
                                                255, 36, 117, 183)),
                                      ),
                                    ),
                                    if (index != venue.subVenues.length - 1)
                                      const Divider(
                                        indent: 16,
                                        endIndent: 16,
                                        thickness: 1,
                                      ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                    color: Color.fromARGB(255, 158, 157, 157),
                  ),
                  // Menu Options
                  ListTile(
                    leading: const Icon(Icons.restaurant_menu),
                    title: const Text(
                      'Menu Options',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 300.0, // Set the height as needed
                            child: ListView.builder(
                              itemCount: venue.subVenues.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          venue.subVenues[index].menuOptions
                                              .map(
                                                (menuOption) =>
                                                    '${menuOption.packageName} - ${menuOption.packagePrice}',
                                              )
                                              .join('\n'),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Description: ${venue.subVenues[index].menuOptions.map((menuOption) => menuOption.packageDescription).join('\n')}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // Decor Options
                  ListTile(
                    leading: const Icon(Icons.format_paint),
                    title: const Text(
                      'Decor Options',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 300.0, // Set the height as needed
                            child: ListView.builder(
                              itemCount: venue.subVenues.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          venue.subVenues[index].decorOptions
                                              .map(
                                                (decorOption) =>
                                                    '${decorOption.decorName} - ${decorOption.decorPrice}',
                                              )
                                              .join('\n'),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'For Event Type: ${venue.subVenues[index].decorOptions.map((decorOption) => decorOption.forEventType).join('\n')}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // Booking Charges
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: const Text(
                      'Booking Charges',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 300.0, // Set the height as needed
                            child: ListView.builder(
                              itemCount: venue.subVenues.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          venue.subVenues[index].nameOfSubVenue,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Booking Charges:\n${venue.subVenues[index].bookingCharges.map((bookingCharge) => '${bookingCharge.bookingChargeName} - ${bookingCharge.bookingChargePrice}').join('\n')}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Service Options
                  ListTile(
                    leading: const Icon(Icons.room_service),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Service Options',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          venue.serviceOptions.join('\n'),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  // Accessibility Options
                  ListTile(
                    leading: const Icon(Icons.accessibility_new),
                    title: const Text(
                      'Accessibility Options',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      venue.accessabilityOptions.join(', '),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                  ),
                  // Refund Policy
                  ListTile(
                    leading: const Icon(Icons.receipt),
                    title: const Text(
                      'Refund Policy',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: venue.refundPolicy.map((policy) {
                        return Text(
                          policy,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                  ),
                  // Contact Number
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text('Contact Number: ${venue.contactNumber}'),
                  ),
                  // Website Link
                  if (venue.websiteLink != null)
                    ListTile(
                      leading: const Icon(Icons.link),
                      title: Text('Website Link: ${venue.websiteLink}'),
                    ),
                  const Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                  ),
                  // Other Information
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      venue.description ?? 'No description available',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                  ),
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: Column(children: [
                      Text('AR Enabled: ${venue.arEnabled ? 'Yes' : 'No'}'),
                      if (venue.arEnabled)
                        ElevatedButton(
                          onPressed: () {
                            _launchApp();
                          },
                          child: const Text('View in AR'),
                        ),
                    ]),
                  ),
                  ListTile(
                    leading: const Icon(Icons.panorama),
                    title: Text(
                        'Paranoma Enabled: ${venue.paranomaEnabled ? 'Yes' : 'No'}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: Text(
                        'Verified Status: ${venue.verifiedStatus ? 'Verified' : 'Not Verified'}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.wifi),
                    title: Text(
                        'Wifi: ${venue.wifi ? 'Available (Cost: ${venue.wifiCost})' : 'Not Available'}'),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60.0,
              child: BottomAppBar(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cost / Person: ${venue.pricePerPerson}'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(),
                            ),
                          );
                        },
                        child: const Text('Book Now'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const AppNavBar(),
          ],
        ),
      ),
    );
  }
}
