import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../widgets/app_nav_bar.dart';
import 'dart:convert';
import '../widgets/property_type_list.dart';
import '../store/store.dart';
import '../models/venue_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/filter_search.dart';
import '../theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    AppDataStore.fetchDataAtAppLaunch().then((_) {
      _timer = Timer(const Duration(seconds: 5), () {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer
        .cancel(); // Cancel the timer to prevent calling setState on a disposed widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      // Apply your custom card theme here
      data: theme,
      child: Scaffold(
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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled:
                                true, // Set isScrollControlled to true
                            builder: (BuildContext context) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        0), // Set horizontal padding to zero
                                child:
                                    FilterWidget(), // Return the FilterWidget directly
                              );
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
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
                              color: Colors
                                  .white, // Set the background color to white
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
                                      style: textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
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
            else if (AppDataStore.dataList.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Establishing Connection...'),
                    ],
                  ),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class VenueCardWidget extends StatelessWidget {
  final Venue venue;

  const VenueCardWidget({Key? key, required this.venue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      color: const Color.fromARGB(
          255, 255, 255, 255), // Set the card background to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
                    height: double.maxFinite,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imageLink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 16, // Square aspect ratio for large images
                enlargeCenterPage: true,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                pauseAutoPlayOnManualNavigate: true,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              venue.nameOfVenue,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
