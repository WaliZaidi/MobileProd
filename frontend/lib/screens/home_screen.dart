// import 'package:flutter/material.dart';
// import '../store/store.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch data at app launch
//     AppDataStore.fetchDataAtAppLaunch();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               // Fetch data at app launch
//               await AppDataStore.fetchDataAtAppLaunch();
//             },
//             child: const Text('Fetch Data at App Launch'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               AppDataStore.selectVenueByName("Wedding Rings Marquee");
//               print('Current Venue: ${AppDataStore.currentVenue}');
//             },
//             child: const Text('Select Venue by Name'),
//           ),
//           if (AppDataStore.dataList.isNotEmpty)
//             Column(
//               //this part displays the data
//               children: [
//                 const Text('Fetched Data:'),
//                 for (var venue in AppDataStore.dataList.take(3))
//                   ListTile(
//                     title: Text(venue.nameOfVenue),
//                     subtitle: Text(venue.locationOfVenue),
//                     onTap: () => AppDataStore.selectVenue(
//                         AppDataStore.dataList.indexOf(venue)),
//                   ),
//               ],
//             )
//           else
//             const Text('No Data Available'),
//           if (AppDataStore.currentVenue != null)
//             Column(
//               children: [
//                 const Text('Current Venue:'),
//                 Text(AppDataStore.currentVenue.toString()),
//               ],
//             )
//           else
//             const Text('No Current Venue Selected'),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../widgets/app_nav_bar.dart';
import 'dart:convert';
import '../widgets/property_type_list.dart';
import '../store/store.dart';
import '../models/venue_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import '../screens/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data at app launch
    AppDataStore.fetchDataAtAppLaunch();
  }

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      bottomNavigationBar: const AppNavBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 165,
            floating: false,
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: PropertyTypeList(),
                  ),
                  Positioned(
                    top: 65.0,
                    right: 8.0,
                    child: IconButton(
                      onPressed: () {
                        print('Filter button pressed');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Filter Button Pressed'),
                              content: const Text(
                                  'This is the text you want to show.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.tune),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    right: 72.0,
                    top: 60.0,
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed('booking-details');
                      },
                      child: Hero(
                        tag: 'search',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(32.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 8.0,
                                spreadRadius: 8.0,
                                offset: const Offset(0.0, 4.0),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search),
                              const SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Where to?',
                                    style: textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Anywhere • Any week • Add events',
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (AppDataStore.dataList.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final venue = AppDataStore.dataList[index];
                  return VenueCardWidget(venue: venue);
                },
                childCount: AppDataStore.dataList.length,
              ),
            )
          else
            const SliverFillRemaining(
              child: Center(
                child: Text('No Data Available'),
              ),
            ),
        ],
      ),
    );
  }
}

// class VenueCardWidget extends StatelessWidget {
//   final Venue venue;

//   const VenueCardWidget({required this.venue});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               venue.nameOfVenue,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text('Location: ${venue.locationOfVenue}'),
//             const SizedBox(height: 8),
//             Text('Rating: ${venue.rating}'), // Assuming 'rating' is a String
//             const SizedBox(height: 8),
//             // Add more fields as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

class VenueCardWidget extends StatelessWidget {
  final Venue venue;

  const VenueCardWidget({required this.venue});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: venue.images.expand((imageUrl) {
                return imageUrl.toImageList().map((imageLink) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.network(
                      imageLink,
                      fit: BoxFit.cover,
                    ),
                  );
                });
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0, // Square aspect ratio for large images
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              venue.nameOfVenue,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text('Location: ${venue.locationOfVenue}'),
            const SizedBox(height: 8),
            Text('Rating: ${venue.rating}'), // Assuming 'rating' is a String
            const SizedBox(height: 8),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
