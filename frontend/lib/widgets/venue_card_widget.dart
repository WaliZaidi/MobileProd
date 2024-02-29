// import 'package:flutter/material.dart';
// import '../models/venue_model.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class VenueCardWidget extends StatelessWidget {
//   final Venue venue;

//   const VenueCardWidget({Key? key, required this.venue}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(8),
//       color: const Color.fromARGB(
//           255, 255, 255, 255), // Set the card background to white
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CarouselSlider(
//               items: venue.images.expand((imageUrl) {
//                 return imageUrl.toImageList().map((imageLink) {
//                   return Container(
//                     width: double.infinity,
//                     height: double.maxFinite,
//                     margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.network(
//                         imageLink,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 });
//               }).toList(),
//               options: CarouselOptions(
//                 autoPlay: true,
//                 aspectRatio: 16 / 16, // Square aspect ratio for large images
//                 enlargeCenterPage: true,
//                 viewportFraction: 1,
//                 enableInfiniteScroll: true,
//                 pauseAutoPlayOnManualNavigate: true,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               venue.nameOfVenue,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
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

import 'package:flutter/material.dart';
import 'package:frontend/store/store.dart';
import '../models/venue_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/venue_details_screen.dart'; // Import the venue details screen

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
            GestureDetector(
              onTap: () {
                AppDataStore.selectVenueByName(venue.nameOfVenue);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VenueDetailsScreen(venue: AppDataStore.currentVenue!),
                  ),
                );
              },
              child: Text(
                venue.nameOfVenue,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
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
