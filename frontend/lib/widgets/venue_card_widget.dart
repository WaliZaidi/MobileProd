import 'package:flutter/material.dart';
import 'package:frontend/screens/wishlist_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/widgets/loader_bars.dart';
import '../models/venue_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/venue_details_screen.dart'; // Import the venue details screen

// class VenueCardWidget extends StatefulWidget {
//   final Venue venue;

//   VenueCardWidget({Key? key, required this.venue}) : super(key: key);

//   @override
//   _VenueCardWidgetState createState() => _VenueCardWidgetState();
// }

// class _VenueCardWidgetState extends State<VenueCardWidget> {
//   late bool isFavourite;

//   @override
//   void initState() {
//     super.initState();
//     isFavourite = AppDataStore.isVenueFavorite(widget.venue);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.all(8),
//       color: const Color.fromARGB(255, 255, 255, 255),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   CarouselSlider(
//                     items: widget.venue.images.expand((imageUrl) {
//                       return imageUrl.toImageList().map((imageLink) {
//                         return Container(
//                           width: double.infinity,
//                           height: double.maxFinite,
//                           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8.0),
//                             child: Image.network(
//                               imageLink,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       });
//                     }).toList(),
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       aspectRatio: 16 / 16,
//                       enlargeCenterPage: true,
//                       viewportFraction: 1,
//                       enableInfiniteScroll: true,
//                       pauseAutoPlayOnManualNavigate: true,
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(107, 255, 255, 255),
//                           spreadRadius: -2,
//                           blurRadius: 0,
//                           offset: Offset(0, 0),
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: Icon(
//                         isFavourite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavourite ? Colors.red : null,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           if (AppDataStore.loggedInNotifier.value == false) {
//                             LoaderBar.showMessage(
//                                 context, "Please login to add to favourites!");
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const WishListScreen(),
//                               ),
//                             );
//                             return;
//                           } else {
//                             if (isFavourite) {
//                               LoaderBar.showMessage(
//                                   context, "Venue removed from favourites!");
//                               AppDataStore.removeFavouriteVenue(widget.venue);
//                             } else {
//                               LoaderBar.showMessage(
//                                   context, "Venue added to favourites!");
//                               AppDataStore.addFavouriteVenue(widget.venue);
//                             }
//                             isFavourite = !isFavourite;
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               GestureDetector(
//                 onTap: () {
//                   AppDataStore.selectVenueByName(widget.venue.nameOfVenue);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           VenueDetailsScreen(venue: AppDataStore.currentVenue!),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.venue.nameOfVenue,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(' ⭐ ${widget.venue.rating}',
//                             style:
//                                 const TextStyle(fontWeight: FontWeight.bold)),
//                         Text(' (${widget.venue.numberOfReviews})'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text('Location: ${widget.venue.locationOfVenue}'),
//               const SizedBox(height: 8),
//               Text('Type: ${widget.venue.typeOfVenue.join(', ')}'),
//               const SizedBox(height: 8),
//               Text(
//                 'Rs.${widget.venue.pricePerPerson}/person',
//                 style: const TextStyle(
//                     decoration: TextDecoration.underline,
//                     fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 15),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class VenueCardWidget extends StatefulWidget {
  final Venue venue;

  VenueCardWidget({Key? key, required this.venue}) : super(key: key);

  @override
  _VenueCardWidgetState createState() => _VenueCardWidgetState();
}

class _VenueCardWidgetState extends State<VenueCardWidget> {
  late bool isFavourite;

  @override
  void initState() {
    super.initState();
    isFavourite = AppDataStore.isVenueFavorite(widget.venue);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppDataStore.selectVenueByName(widget.venue.nameOfVenue);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VenueDetailsScreen(venue: AppDataStore.currentVenue!),
          ),
        );
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(8),
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
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
                    Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(107, 255, 255, 255),
                            spreadRadius: -2,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isFavourite ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            if (AppDataStore.loggedInNotifier.value == false) {
                              LoaderBar.showMessage(context,
                                  "Please login to add to favourites!");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WishListScreen(),
                                ),
                              );
                              return;
                            } else {
                              if (isFavourite) {
                                LoaderBar.showMessage(
                                    context, "Venue removed from favourites!");
                                AppDataStore.removeFavouriteVenue(widget.venue);
                              } else {
                                LoaderBar.showMessage(
                                    context, "Venue added to favourites!");
                                AppDataStore.addFavouriteVenue(widget.venue);
                              }
                              isFavourite = !isFavourite;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.venue.nameOfVenue,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(' ⭐ ${widget.venue.rating}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(' (${widget.venue.numberOfReviews})'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Location: ${widget.venue.locationOfVenue}'),
                const SizedBox(height: 8),
                Text('Type: ${widget.venue.typeOfVenue.join(', ')}'),
                const SizedBox(height: 8),
                Text(
                  'Rs.${widget.venue.pricePerPerson}/person',
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
