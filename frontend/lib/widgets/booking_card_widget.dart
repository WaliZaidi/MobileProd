import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/venue_model.dart';
import 'package:frontend/screens/venue_details_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/widgets/loader_bars.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/screens/booking/booking_review.dart';

// class BookingListCardWidget extends StatefulWidget {
//   final Venue venue;

//   BookingListCardWidget({Key? key, required this.venue}) : super(key: key);

//   @override
//   _BookingListCardWidgetState createState() => _BookingListCardWidgetState();
// }

// class _BookingListCardWidgetState extends State<BookingListCardWidget> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.all(8),
//       color: const Color.fromARGB(255, 255, 255, 255),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CarouselSlider(
//             items: widget.venue.images.expand((imageUrl) {
//               return imageUrl.toImageList().map((imageLink) {
//                 return Container(
//                   width: double.infinity,
//                   height: double.maxFinite,
//                   margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.network(
//                       imageLink,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               });
//             }).toList(),
//             options: CarouselOptions(
//               autoPlay: true,
//               aspectRatio: 16 / 16,
//               enlargeCenterPage: true,
//               viewportFraction: 1,
//               enableInfiniteScroll: true,
//               pauseAutoPlayOnManualNavigate: true,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 isExpanded = !isExpanded;
//               });
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//                 Text(
//                   widget.venue.nameOfVenue,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 if (isExpanded) ...[
//                   const SizedBox(height: 8),
//                   Text('Location: ${widget.venue.locationOfVenue}'),
//                   const SizedBox(height: 8),
//                   Text('Type: ${widget.venue.typeOfVenue.join(', ')}'),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rs.${widget.venue.pricePerPerson}/person',
//                     style: const TextStyle(
//                       decoration: TextDecoration.underline,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your action here
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 255, 255, 255),
//                     ),
//                     foregroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 0, 0, 0),
//                     ),
//                     side: MaterialStateProperty.all<BorderSide>(
//                       const BorderSide(
//                         color: Color.fromARGB(255, 0, 0, 0),
//                       ),
//                     ),
//                   ),
//                   child: const Text("View Booking Details"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class BookingListCardWidget extends StatefulWidget {
  final Venue venue;

  BookingListCardWidget({Key? key, required this.venue}) : super(key: key);

  @override
  _BookingListCardWidgetState createState() => _BookingListCardWidgetState();
}

class _BookingListCardWidgetState extends State<BookingListCardWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: widget.venue.images.expand((imageUrl) {
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
              aspectRatio: 16 / 16,
              enlargeCenterPage: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              pauseAutoPlayOnManualNavigate: true,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  widget.venue.nameOfVenue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Click on the name to expand details",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Location: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.venue.locationOfVenue,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Type: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.venue.typeOfVenue.join(', '),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Service Options: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.venue.serviceOptions.join(', '),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Accessibility Options: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.venue.accessabilityOptions.join(', '),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Refund Policy: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.venue.refundPolicy.join(', '),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (AppDataStore.getBookingById(widget.venue.nameOfVenue) !=
                        '') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingReviewScreen(
                                  booking: AppDataStore.getBookingById(
                                      widget.venue.nameOfVenue)!)));
                    } else {
                      LoaderBar.showMessage(
                          context, "No booking found for this venue!");
                      GoRouter.of(context).go('/booking');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 255, 255),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 0, 0),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  child: const Text("View Booking Details"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
