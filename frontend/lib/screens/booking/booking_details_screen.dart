import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:frontend/models/booking_model.dart';
import 'package:frontend/models/user_modal.dart';
import 'package:frontend/screens/login_signup_screen.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import 'package:frontend/models/venue_model.dart';
import 'package:frontend/store/store.dart';

import 'booking_confirmation_screen.dart';

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
  int guestCount = 0;
  late Booking bookingForVenue; //will get initialized on booking completion

  @override
  Widget build(BuildContext context) {
    List<AvailableDate> availableDates = selectedSubhall?.availableDates ?? [];

    return Theme(
      data: CustomTheme
          .theme, // Replace 'theme' with the actual import or variable name
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shadowColor: Colors.transparent,
          title: const Text(
            'Booking',
            style: TextStyle(
              fontSize: 20, // Set the font size to 24
              fontFamily: 'Montserrat', // Set the font family
              fontWeight: FontWeight.w500,
              color: Colors.black, // Set the font color to black
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          toolbarHeight: 80, // Set the toolbar height to add padding
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Number of Guests:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        guestCount = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: DropdownButton<SubVenue>(
                value: selectedSubhall,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                hint: const Text('Select a subhall'),
                items: widget.venue.subVenues
                    .where(
                        (subVenue) => subVenue.capacityOfSubVenue >= guestCount)
                    .map((subVenue) {
                  return DropdownMenuItem<SubVenue>(
                    value: subVenue,
                    child: Text(subVenue.nameOfSubVenue),
                  );
                }).toList(),
                onChanged: (SubVenue? value) {
                  setState(() {
                    selectedSubhall = value;
                    selectedDates.clear();
                    selectedOptions.clear();
                  });
                },
              ),
            ),
            if (selectedSubhall != null) ...[
              ExpansionTile(
                title: const Row(
                  children: [
                    Icon(Icons.menu),
                    SizedBox(width: 8.0),
                    Text('Menu Options'),
                  ],
                ),
                children: [
                  Column(
                    children: selectedSubhall!.menuOptions.map((menuOption) {
                      return CheckboxListTile(
                        title: Text(
                          '${menuOption.packageName} - ${menuOption.packagePrice}',
                        ),
                        subtitle: Text(menuOption.packageDescription),
                        value:
                            selectedOptions['menu_${menuOption.packageName}'] ??
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
                ],
              ),
              ExpansionTile(
                title: const Row(
                  children: [
                    Icon(Icons.dehaze),
                    SizedBox(width: 8.0),
                    Text('Decor Options'),
                  ],
                ),
                children: [
                  Column(
                    children: selectedSubhall!.decorOptions.map((decorOption) {
                      return CheckboxListTile(
                        title: Text(decorOption.decorName),
                        subtitle: Text(decorOption.decorPrice.toString()),
                        value:
                            selectedOptions['decor_${decorOption.decorName}'] ??
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
                ],
              ),
              ExpansionTile(
                title: const Row(
                  children: [
                    Icon(Icons.dehaze),
                    SizedBox(width: 8.0),
                    Text('Booking Options'),
                  ],
                ),
                children: [
                  Column(
                    children:
                        selectedSubhall!.bookingCharges.map((bookingCharge) {
                      return CheckboxListTile(
                        title: Text(bookingCharge.bookingChargeName),
                        subtitle:
                            Text(bookingCharge.bookingChargePrice.toString()),
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
                ],
              ),
            ],
          ],
        ),
        //
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80.0, // Set the desired height
              child: BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (AppDataStore.currentUser == null)
                            const Text(
                              'Please login to complete the booking!',
                            ),
                          const SizedBox(
                            width: 22.0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Cost: Rs. ${calculateTotalCost()} /-'),
                          ElevatedButton(
                            onPressed: selectedSubhall != null &&
                                    guestCount > 0 &&
                                    AppDataStore.currentUser != null
                                ? () {
                                    // Handle booking logic
                                    bookingForVenue = Booking(
                                      venue: widget.venue,
                                      subVenue: selectedSubhall!,
                                      guestCount: guestCount,
                                      selectedOptions:
                                          selectedOptions.keys.toList(),
                                      selectedDates: selectedDates,
                                      totalAmount: calculateTotalCost(),
                                      status: 'Pending',
                                      date: DateTime.now().day.toString(),
                                      time: DateTime.now().isUtc.toString(),
                                      user: AppDataStore.currentUser!,
                                    );
                                    AppDataStore.addBooking(bookingForVenue);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingConfirmationScreen(
                                          bookingDetails: bookingForVenue,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            child: const Text('Complete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Second BottomAppBar component
            const AppNavBar(),
          ],
        ),
      ),
    );
  }

  double calculateTotalCost() {
    // Calculate the total cost based on selected options
    double totalCost =
        (AppDataStore.currentVenue?.pricePerPerson ?? 0.0).toDouble();
    if (guestCount > 0) {
      totalCost =
          (AppDataStore.currentVenue?.pricePerPerson ?? 0.0).toDouble() *
              guestCount;
    }

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
          case 'booking': // Add similar cases for decor and booking options
            BookingCharge? selectedOption = selectedSubhall!.bookingCharges
                .firstWhereOrNull((bookingCharge) =>
                    bookingCharge.bookingChargeName == optionName);
            if (selectedOption != null) {
              totalCost += selectedOption.bookingChargePrice;
            }
            break;
          // Add similar cases for decor and booking options
        }
      }
    });
    return totalCost;
  }
}
