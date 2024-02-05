// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../widgets/property_type_list.dart';
// import '../widgets/app_nav_bar.dart';
// import '../models/property.dart';
// // import '../screens/wishlist_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       bottomNavigationBar: const AppNavBar(),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 165, //this is the height of the overall top bar
//             floating: false,
//             pinned: true,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 1.0,
//                     spreadRadius: 1.0,
//                     offset: const Offset(0.0, 1.0),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   const Align(
//                     alignment: Alignment.bottomCenter,
//                     child: PropertyTypeList(),
//                   ),
//                   Positioned(
//                     top: 65.0,
//                     right: 8.0,
//                     child: IconButton(
//                       onPressed: () {
//                         print(
//                             'Filter button pressed'); //print statement, remove later
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Filter Button Pressed'),
//                               content: const Text(
//                                   'This is the text you want to show.'),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text('OK'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       icon: const Icon(Icons.tune),
//                     ),
//                   ),
//                   Positioned(
//                     left: 16.0,
//                     right: 72.0,
//                     top: 60.0,
//                     child: GestureDetector(
//                       onTap: () {
//                         context.pushNamed('booking-details');
//                       },
//                       child: Hero(
//                         tag: 'search',
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                             vertical: 8.0,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(32.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 blurRadius: 8.0,
//                                 spreadRadius: 8.0,
//                                 offset: const Offset(0.0, 4.0),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.search),
//                               const SizedBox(width: 8.0),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Where to?',
//                                     style: textTheme.bodyMedium!
//                                         .copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     'Anywhere • Any week • Add events',
//                                     style: textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 // this is where we will handle the data from the node API
//                 // final property = Property.sampleData[index];
//                 // return PropertyCard(property: property);
//                 return Container(); // Placeholder for now
//               },
//               childCount: Property.sampleData.length,
//             ),
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     // Navigate to the WishlistScreen
//       //     Navigator.of(context).push(
//       //       MaterialPageRoute(builder: (context) => const WishlistScreen()),
//       //     );
//       //   },
//       //   child: const Icon(Icons.favorite), //this is really useful, we can add this on later for when we need a squared instant button
//       // ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;
// import '../widgets/app_nav_bar.dart';
// import 'dart:convert';
// import '../widgets/property_type_list.dart';

// // import '../screens/wishlist_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   Future<List<Map<String, dynamic>>> fetchData() async {
//     final response =
//         await http.get(Uri.parse('http://192.168.56.1:4000/query/search'));
//     if (response.statusCode == 200) {
//       return List<Map<String, dynamic>>.from(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       bottomNavigationBar: const AppNavBar(),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 165,
//             floating: false,
//             pinned: true,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 1.0,
//                     spreadRadius: 1.0,
//                     offset: const Offset(0.0, 1.0),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   const Align(
//                     alignment: Alignment.bottomCenter,
//                     child: PropertyTypeList(),
//                   ),
//                   Positioned(
//                     top: 65.0,
//                     right: 8.0,
//                     child: IconButton(
//                       onPressed: () {
//                         print('Filter button pressed');
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Filter Button Pressed'),
//                               content: const Text(
//                                   'This is the text you want to show.'),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text('OK'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       icon: const Icon(Icons.tune),
//                     ),
//                   ),
//                   Positioned(
//                     left: 16.0,
//                     right: 72.0,
//                     top: 60.0,
//                     child: GestureDetector(
//                       onTap: () {
//                         context.pushNamed('booking-details');
//                       },
//                       child: Hero(
//                         tag: 'search',
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                             vertical: 8.0,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(32.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 blurRadius: 8.0,
//                                 spreadRadius: 8.0,
//                                 offset: const Offset(0.0, 4.0),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.search),
//                               const SizedBox(width: 8.0),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Where to?',
//                                     style: textTheme.bodyMedium!
//                                         .copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     'Anywhere • Any week • Add events',
//                                     style: textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return FutureBuilder<List<Map<String, dynamic>>>(
//                   future: fetchData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (snapshot.data == null ||
//                         index >= snapshot.data!.length) {
//                       return const Text('Invalid index or data is null');
//                     } else {
//                       final venueData = snapshot.data![index];

//                       // Extracting the first image link
//                       String imageUrl = venueData['images'][0]['link1'] ?? '';

//                       return VenueCard(
//                         imageUrl: imageUrl,
//                         name: venueData['nameOfVenue'],
//                         pricePerHead: venueData['pricePerPerson'],
//                         percentage: venueData[
//                             'rating'], // Assuming 'percentage' is the rating
//                       );
//                     }
//                   },
//                 );
//               },
//               childCount: 1, // Change this to the length of your data
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VenueCard extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String pricePerHead;
//   final String percentage;

//   const VenueCard({
//     required this.imageUrl,
//     required this.name,
//     required this.pricePerHead,
//     required this.percentage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           // Image carousel
//           // You can use a carousel package or create a custom solution for image carousel here

//           // Venue name
//           Text(
//             name,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),

//           // Price per head
//           Text('Price per head: $pricePerHead'),

//           // Percentage
//           Text('Percentage: $percentage'),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../services/mobile_API.dart' as mobile_api;

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               final data = await mobile_api.fetchData();
//               print(data);
//             },
//             child: const Text('Fetch Data'),
//           ),
//           FutureBuilder<String>(
//             future: mobile_api.fetchData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 final jsonData = snapshot.data!;
//                 return Column(
//                   children: [
//                     const Text('Fetched Data:'),
//                     Text(jsonData), // Display the raw JSON data as a string
//                   ],
//                 );
//               } else {
//                 return const Text('No Data Available');
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../store/store.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // Fetch data at app launch
              await AppDataStore.fetchDataAtAppLaunch();
              print(
                  'Fetched Data: Fetched ${AppDataStore.dataList.length} items');
            },
            child: const Text('Fetch Data at App Launch'),
          ),
          ElevatedButton(
            onPressed: () async {
              AppDataStore.selectVenueByName("Wedding Rings Marquee");
              print('Current Venue: ${AppDataStore.currentVenue}');
            },
            child: const Text('Select Venue by Name'),
          ),
          if (AppDataStore.dataList.isNotEmpty)
            Column(
              //this part displays the data
              children: [
                const Text('Fetched Data:'),
                for (var venue in AppDataStore.dataList.take(3))
                  ListTile(
                    title: Text(venue.nameOfVenue),
                    subtitle: Text(venue.locationOfVenue),
                    onTap: () => AppDataStore.selectVenue(
                        AppDataStore.dataList.indexOf(venue)),
                  ),
              ],
            )
          else
            const Text('No Data Available'),
          if (AppDataStore.currentVenue != null)
            Column(
              children: [
                const Text('Current Venue:'),
                Text(AppDataStore.currentVenue.toString()),
              ],
            )
          else
            const Text('No Current Venue Selected'),
        ],
      ),
    );
  }
}
