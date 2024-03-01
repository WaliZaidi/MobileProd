import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/venue_model.dart';
import '../store/store.dart';

// class BookingScreen extends StatefulWidget {
//   final Venue venue = AppDataStore.currentVenue!;

//   BookingScreen({Key? key}) : super(key: key);

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   Map<String, bool> selectedOptions = {};
//   List<AvailableDate> selectedDates = [];
//   List<SubVenue> selectedSubhalls = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Booking'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: ListView(
//         children: [
//           ExpansionTile(
//             title: const Text('Menu Options'),
//             children: widget.venue.subVenues.expand((subVenue) {
//               return subVenue.menuOptions.map((menuOption) {
//                 return CheckboxListTile(
//                   title: Text(
//                       '${menuOption.packageName} - ${menuOption.packagePrice}'),
//                   value: selectedOptions['menu_${menuOption.packageName}'] ??
//                       false,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       selectedOptions['menu_${menuOption.packageName}'] =
//                           value ?? false;
//                     });
//                   },
//                 );
//               }).toList();
//             }).toList(),
//           ),
//           ExpansionTile(
//             title: const Text('Decor Options'),
//             children: widget.venue.subVenues.expand((subVenue) {
//               return subVenue.decorOptions.map((decorOption) {
//                 return CheckboxListTile(
//                   title: Text(
//                       '${decorOption.decorName} - ${decorOption.decorPrice}'),
//                   value: selectedOptions['decor_${decorOption.decorName}'] ??
//                       false,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       selectedOptions['decor_${decorOption.decorName}'] =
//                           value ?? false;
//                     });
//                   },
//                 );
//               }).toList();
//             }).toList(),
//           ),
//           ExpansionTile(
//             title: const Text('Booking Charges'),
//             children: widget.venue.subVenues.expand((subVenue) {
//               return subVenue.bookingCharges.map((bookingCharge) {
//                 return CheckboxListTile(
//                   title: Text(
//                       '${bookingCharge.bookingChargeName} - ${bookingCharge.bookingChargePrice}'),
//                   value: selectedOptions[
//                           'booking_${bookingCharge.bookingChargeName}'] ??
//                       false,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       selectedOptions[
//                               'booking_${bookingCharge.bookingChargeName}'] =
//                           value ?? false;
//                     });
//                   },
//                 );
//               }).toList();
//             }).toList(),
//           ),
//           ExpansionTile(
//             title: const Text('Available Dates'),
//             children: widget.venue.subVenues.expand((subVenue) {
//               return (subVenue.availableDates ?? []).map((availableDate) {
//                 return CheckboxListTile(
//                   title: Text(
//                       '${availableDate.date} - ${availableDate.startTime} to ${availableDate.endTime}'),
//                   value: selectedDates.contains(availableDate),
//                   onChanged: (bool? value) {
//                     setState(() {
//                       if (value != null) {
//                         if (value) {
//                           selectedDates.add(availableDate);
//                         } else {
//                           selectedDates.remove(availableDate);
//                         }
//                       }
//                     });
//                   },
//                 );
//               }).toList();
//             }).toList(),
//           ),
//           ExpansionTile(
//             title: const Text('Subhalls'),
//             children: (widget.venue.subVenues ?? []).map((subVenue) {
//               return CheckboxListTile(
//                 title: Text(subVenue.nameOfSubVenue),
//                 subtitle:
//                     Text('Capacity: ${subVenue.capacityOfSubVenue.toString()}'),
//                 value: selectedSubhalls.contains(subVenue),
//                 onChanged: (bool? value) {
//                   setState(() {
//                     if (value != null) {
//                       if (value) {
//                         selectedSubhalls.add(subVenue);
//                       } else {
//                         selectedSubhalls.remove(subVenue);
//                       }
//                     }
//                   });
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Total Cost: ${calculateTotalCost()}'),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle booking logic
//                 },
//                 child: const Text('Book Now'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   double calculateTotalCost() {
//     // Calculate the total cost based on selected options
//     double totalCost = 0.0;
//     selectedOptions.forEach((key, value) {
//       if (value) {
//         // Extract the price from the key
//         String optionType = key.split('_')[0];
//         String optionName = key.split('_')[1];
//         switch (optionType) {
//           case 'menu':
//             MenuOption? selectedOption = widget.venue.subVenues
//                 .expand((subVenue) => subVenue.menuOptions)
//                 .firstWhereOrNull(
//                     (menuOption) => menuOption.packageName == optionName);
//             if (selectedOption != null) {
//               totalCost += selectedOption.packagePrice;
//             }
//             break;
//           case 'decor':
//             DecorOption? selectedOption = widget.venue.subVenues
//                 .expand((subVenue) => subVenue.decorOptions)
//                 .firstWhereOrNull(
//                     (decorOption) => decorOption.decorName == optionName);
//             if (selectedOption != null) {
//               totalCost += selectedOption.decorPrice;
//             }
//             break;
//           case 'booking':
//             BookingCharge? selectedOption = widget.venue.subVenues
//                 .expand((subVenue) => subVenue.bookingCharges)
//                 .firstWhereOrNull((bookingCharge) =>
//                     bookingCharge.bookingChargeName == optionName);
//             if (selectedOption != null) {
//               totalCost += selectedOption.bookingChargePrice;
//             }
//             break;
//         }
//       }
//     });
//     return totalCost;
//   }
// }

class BookingScreen extends StatefulWidget {
  final Venue venue = AppDataStore.currentVenue!;

  BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Map<String, bool> selectedOptions = {};
  List<AvailableDate> selectedDates = [];
  SubVenue? selectedSubhall;

  @override
  Widget build(BuildContext context) {
    List<AvailableDate> availableDates = selectedSubhall?.availableDates ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          DropdownButton<SubVenue>(
            value: selectedSubhall,
            hint: const Text('Select a subhall'),
            items: widget.venue.subVenues.map((subVenue) {
              return DropdownMenuItem<SubVenue>(
                value: subVenue,
                child: Text(subVenue.nameOfSubVenue),
              );
            }).toList(),
            onChanged: (SubVenue? value) {
              setState(() {
                selectedSubhall = value;
                selectedDates
                    .clear(); // Clear selected dates when subhall changes
              });
            },
          ),
          if (selectedSubhall != null) ...[
            ExpansionTile(
              title: const Text('Menu Options'),
              children: selectedSubhall!.menuOptions.map((menuOption) {
                return CheckboxListTile(
                  title: Text(
                    '${menuOption.packageName} - ${menuOption.packagePrice}',
                  ),
                  subtitle: Text(menuOption.packageDescription),
                  value: selectedOptions['menu_${menuOption.packageName}'] ??
                      false,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions['menu_${menuOption.packageName}'] =
                          value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text('Decor Options'),
              children: selectedSubhall!.decorOptions.map((decorOption) {
                return CheckboxListTile(
                  title: Text(
                    '${decorOption.decorName} - ${decorOption.decorPrice}',
                  ),
                  value: selectedOptions['decor_${decorOption.decorName}'] ??
                      false,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions['decor_${decorOption.decorName}'] =
                          value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text('Booking Charges'),
              children: selectedSubhall!.bookingCharges.map((bookingCharge) {
                return CheckboxListTile(
                  title: Text(
                    '${bookingCharge.bookingChargeName} - ${bookingCharge.bookingChargePrice}',
                  ),
                  value: selectedOptions[
                          'booking_${bookingCharge.bookingChargeName}'] ??
                      false,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions[
                              'booking_${bookingCharge.bookingChargeName}'] =
                          value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text('Available Dates'),
              children: availableDates.map((availableDate) {
                return CheckboxListTile(
                  title: Text(
                    '${availableDate.date.day} - ${availableDate.startTime} to ${availableDate.endTime}',
                  ),
                  value: selectedDates.contains(availableDate),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        if (value) {
                          selectedDates.add(availableDate);
                        } else {
                          selectedDates.remove(availableDate);
                        }
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Cost: ${calculateTotalCost()}'),
              ElevatedButton(
                onPressed: () {
                  // Handle booking logic
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotalCost() {
    // Calculate the total cost based on selected options
    double totalCost =
        (AppDataStore.currentVenue?.pricePerPerson ?? 0.0).toDouble();

    selectedOptions.forEach((key, value) {
      if (value) {
        // Extract the price from the key
        String optionType = key.split('_')[0];
        String optionName = key.split('_')[1];
        switch (optionType) {
          case 'menu':
            MenuOption? selectedOption = selectedSubhall!.menuOptions
                .firstWhereOrNull(
                    (menuOption) => menuOption.packageName == optionName);
            if (selectedOption != null) {
              totalCost += selectedOption.packagePrice;
            }
            break;
          case 'decor':
            DecorOption? selectedOption = selectedSubhall!.decorOptions
                .firstWhereOrNull(
                    (decorOption) => decorOption.decorName == optionName);
            if (selectedOption != null) {
              totalCost += selectedOption.decorPrice;
            }
            break;
          case 'booking':
            BookingCharge? selectedOption = selectedSubhall!.bookingCharges
                .firstWhereOrNull((bookingCharge) =>
                    bookingCharge.bookingChargeName == optionName);
            if (selectedOption != null) {
              totalCost += selectedOption.bookingChargePrice;
            }
            break;
        }
      }
    });
    return totalCost;
  }
}
