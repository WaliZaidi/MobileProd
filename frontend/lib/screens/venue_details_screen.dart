import 'package:flutter/material.dart';
import '../store/store.dart';
import '../models/venue_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VenueDetailsScreen extends StatelessWidget {
  final Venue venue;

  const VenueDetailsScreen({Key? key, required this.venue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image Carousel
          SizedBox(
            height: 600, // Adjust the height as needed
            child: CarouselSlider(
              items: venue.images.expand((imageUrl) {
                return imageUrl.toImageList().map((imageLink) {
                  return Container(
                    width: Size.infinite.width,
                    height: 600,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(imageLink),
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
          ),
          // Back Button and Heart Icon
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Handle favorite button tap
              },
            ),
          ),
          // Rest of the content
          ListView(
            padding: const EdgeInsets.only(
                top: 200), // Adjust top padding to match carousel height
            children: [
              // Venue Name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  venue.nameOfVenue,
                  style: const TextStyle(fontSize: 20),
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
              // Location of Venue
              // Other Information
              const Divider(),
              ListTile(
                leading: const Icon(Icons.star),
                title: Text('Rating: ${venue.rating}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.people),
                title:
                    Text('Total Halls Capacity: ${venue.totalHallsCapacity}'),
              ),
              const Divider(),
              // Available Dates
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Available Dates'),
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: const Text('Available Dates'),
                  //       content: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: venue.subVenues.map((subVenue) {
                  //           return ListTile(
                  //             title: Text(subVenue.nameOfSubVenue),
                  //             subtitle: Text(
                  //                 'Capacity: ${subVenue.capacityOfSubVenue}'),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     );
                  //   },
                  // );
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            const Text('Available Dates'),
                            ...venue.subVenues.map((subVenue) {
                              return ListTile(
                                title: Text(subVenue.nameOfSubVenue),
                                subtitle: Text(
                                    'Capacity: ${subVenue.capacityOfSubVenue}'),
                              );
                            }).toList(),
                          ],
                        );
                      });
                },
              ),
              const Divider(
                height: 30,
              ),
              // Menu Options
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: const Text('Menu Options'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Menu Options'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: venue.subVenues.map((subVenue) {
                            return ListTile(
                              title: Text(subVenue.menuOptions
                                  .map((menuOption) =>
                                      '${menuOption.packageName} - ${menuOption.packagePrice}')
                                  .join('\n')),
                              subtitle: Text(
                                  'Description: ${subVenue.menuOptions.map((menuOption) => menuOption.packageDescription).join('\n')}'),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),

              const Divider(),
              // Decor Options
              ListTile(
                leading: const Icon(Icons.format_paint),
                title: const Text('Decor Options'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Decor Options'),
                        content: SizedBox(
                          height:
                              200, // Set a fixed height or use a ListView with limited items
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                List.generate(venue.subVenues.length, (index) {
                              return ListTile(
                                title: Text(
                                  venue.subVenues[index].decorOptions
                                      .map((decorOption) =>
                                          '${decorOption.decorName} - ${decorOption.decorPrice}')
                                      .join('\n'),
                                ),
                                subtitle: Text(
                                  'For Event Type: ${venue.subVenues[index].decorOptions.map((decorOption) => decorOption.forEventType).join('\n')}',
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const Divider(),
              // Booking Charges
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Booking Charges'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Booking Charges'),
                        content: SizedBox(
                          height:
                              200, // Set a fixed height or use a ListView with limited items
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                List.generate(venue.subVenues.length, (index) {
                              return ListTile(
                                title: Text(
                                  venue.subVenues[index].bookingCharges
                                      .map((bookingCharge) =>
                                          '${bookingCharge.bookingChargeName} - ${bookingCharge.bookingChargePrice}')
                                      .join('\n'),
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              // Reviews
              ListTile(
                leading: const Icon(Icons.rate_review),
                title: Text('Reviews (${venue.reviews.length})'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Reviews'),
                        content: ListView.builder(
                          shrinkWrap: true,
                          itemCount: venue.reviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                '${venue.reviews[index].nameOfVenue} - ${venue.reviews[index].rating}',
                              ),
                              subtitle: Text(venue.reviews[index].text),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              // Service Options
              ListTile(
                leading: const Icon(Icons.room_service),
                title: const Text('Service Options'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Service Options'),
                        content: ListView.builder(
                          shrinkWrap: true,
                          itemCount: venue.serviceOptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(venue.serviceOptions[index]),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              // Accessibility Options
              ListTile(
                leading: const Icon(Icons.accessibility_new),
                title: const Text('Accessibility Options'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Accessibility Options'),
                        content: ListView.builder(
                          shrinkWrap: true,
                          itemCount: venue.accessabilityOptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(venue.accessabilityOptions[index]),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              // Refund Policy
              ListTile(
                leading: const Icon(Icons.receipt),
                title: const Text('Refund Policy'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Refund Policy'),
                        content: ListView.builder(
                          shrinkWrap: true,
                          itemCount: venue.refundPolicy.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(venue.refundPolicy[index]),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              // Contact Number
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text('Contact Number: ${venue.contactNumber}'),
              ),
              const Divider(),
              // Website Link
              if (venue.websiteLink != null)
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('Website Link'),
                  onTap: () {
                    // Open website link
                  },
                ),
              const Divider(),
              // Other Information
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Description'),
                subtitle: Text(venue.description ?? 'No description available'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.timer),
                title: Text('AR Enabled: ${venue.arEnabled ? 'Yes' : 'No'}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.panorama),
                title: Text(
                    'Paranoma Enabled: ${venue.paranomaEnabled ? 'Yes' : 'No'}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.verified_user),
                title: Text(
                    'Verified Status: ${venue.verifiedStatus ? 'Verified' : 'Not Verified'}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.wifi),
                title: Text(
                    'Wifi: ${venue.wifi ? 'Available (Cost: ${venue.wifiCost})' : 'Not Available'}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
