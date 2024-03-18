import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/booking_model.dart';

import '../models/venue_model.dart'; // Import the models.dart file
import '../services/mobile_API.dart' as api; // Import your api.dart file
import '../models/user_modal.dart'; // Import the user_modal.dart file

class AppDataStore {
  static List<Venue> dataList = [];
  static Venue? currentVenue;
  static UserInfo? currentUser;
  static List<Venue> filteredVenues = [];
  static String url = 'http://192.168.18.16:4000';

  static ValueNotifier<bool> loggedInNotifier = ValueNotifier<bool>(false);

  static void setLoggedIn(bool loggedIn) {
    loggedInNotifier.value = loggedIn;
  }
  // static UserInfo? currentUser;

  static Future<void> fetchDataAtAppLaunch() async {
    try {
      final jsonData = await api.fetchData();

      dataList = jsonData;
    } catch (e, stackTrace) {
      // Handle exceptions
      print('Exception: $e');
      //i want more details on the exception
      print('Exception: ${e.toString()}');
      //show me where this exception is coming from
      print('Exception: $stackTrace');
      print('Exception: ${stackTrace.toString()}');
      throw Exception('Failed to fetch data');
    }
  }

  static void selectVenue(int index) {
    currentVenue = dataList.isNotEmpty ? dataList[index] : null;
    // You can perform additional actions when a venue is selected, such as fetching secondary information.
  }

  static void selectVenueByName(String venueName) {
    // Trim whitespace from the input venueName
    venueName = venueName.trim();

    // Check if venueName is empty
    if (venueName.isEmpty) {
      print('Venue name is empty');
      return;
    }

    // Debugging: Print the values during the search process
    print('Searching for: $venueName');

    // Search for the venue in dataList
    final venue = dataList.firstWhere(
      (venue) => venue.nameOfVenue.trim() == venueName,
      orElse: () => Venue(
        timestamp: '',
        ranking: '',
        nameOfVenue: '',
        locationOfVenue: '',
        plusCode: '',
        typeOfVenue: [],
        numberOfReviews: '',
        serviceOptions: [],
        accessabilityOptions: [],
        rating: '',
        parkingSpace: '',
        numberOfSubhalls: '',
        city: '',
        totalHallsCapacity: '',
        refundPolicy: [],
        contactNumber: '',
        websiteLink: '',
        pricePerPerson: 0,
        description: '',
        arEnabled: false,
        paranomaEnabled: false,
        verifiedStatus: false,
        images: [],
        wifi: false,
        wifiCost: 0,
        subVenues: [],
        reviews: [],
      ),
    );

    // Check if the venue was found
    if (venue.nameOfVenue.isNotEmpty) {
      currentVenue = venue;
      print('Current Venue: ${currentVenue?.nameOfVenue}');
    } else {
      print('Venue not found');
    }
  }

  static void filterVenues(
    //we want to apply frontend filtering to the datalist
    String selectedRating,
    String selectedTypeOfVenue,
    String selectedCity,
    String selectedPricePerPerson,
    String selectedAccessibilityOptions,
    String selectedCapacity,
    String selectedRefundPolicy,
  ) {
    Future<List<String>> sortedNamedVenues = api.fetchFilteredData(
      selectedRating,
      selectedTypeOfVenue,
      selectedCity,
      selectedPricePerPerson,
      selectedAccessibilityOptions,
      selectedCapacity,
      selectedRefundPolicy,
    );

    sortedNamedVenues.then((value) {
      filteredVenues =
          dataList.where((venue) => value.contains(venue.nameOfVenue)).toList();
    });
  }

  static void clearFilteredVenues() {
    filteredVenues = [];
  }

  static void resolveSearchQuery(String query) {
    if (query.isEmpty) {
      filteredVenues = [];
      return;
    }

    final searchResults = dataList.where((venue) {
      return venue.nameOfVenue.toLowerCase().contains(query.toLowerCase());
    }).toList();

    filteredVenues = searchResults;
  }

  static void addBooking(Booking booking) {
    // Add the booking to the user's bookings
    currentUser?.bookedVenues.listOfBookedVenues.add(booking);
  }

  static void removeBooking(Booking booking) {
    // Remove the booking from the user's bookings
    currentUser?.bookedVenues.listOfBookedVenues.remove(booking);
  }

  static Future<bool> signInUser(
    String name,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
    String cnic,
  ) async {
    if (await api.registerUser(
        name, email, phoneNumber, password, confirmPassword, cnic)) {
      print('User registered successfully');
      return true;
    } else {
      throw Exception('Failed to register user');
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    if (await api.loginUser(email, password)) {
      print('User logged in successfully');
      AppDataStore.currentUser = UserInfo(
        id: Random(1000).toString(),
        name: '',
        email: email,
        phone: '1234567890',
        date: DateTime.now().day.toString(),
        time: DateTime.now().isUtc.toString(),
        status: 'active',
        password: password,
        confirmPassword: password,
        cnic: '12345-6789012-3',
      );

      AppDataStore.loggedInNotifier.value = true; // Update loggedInNotifier
      return true;
    } else {
      return false;
    }
  }

  static getCurrentUser() {
    return currentUser;
  }

  static void updateServerUrl(String newUrl) {
    url = newUrl;
  }

  static void addFavouriteVenue(Venue venue) {
    currentUser?.favoriteVenues.favoriteVenues.add(venue);
  }

  static void removeFavouriteVenue(Venue venue) {
    currentUser?.favoriteVenues.favoriteVenues.remove(venue);
  }

  static bool isVenueFavorite(Venue venue) {
    return currentUser?.favoriteVenues.favoriteVenues.contains(venue) ?? false;
  }

  static void updateVenueFavouriteStatus(Venue venue) {
    if (isVenueFavorite(venue)) {
      removeFavouriteVenue(venue);
    } else {
      addFavouriteVenue(venue);
    }
  }

  static Booking? getBookingById(String nameVenue) {
    if (currentUser?.bookedVenues != null) {
      return currentUser!.bookedVenues!.listOfBookedVenues.firstWhere(
        (booking) => booking.venue.nameOfVenue == nameVenue,
        orElse: () => Booking(
            user: UserInfo(
              id: '',
              name: '',
              email: '',
              phone: '',
              date: '',
              time: '',
              status: '',
              password: '',
              confirmPassword: '',
              cnic: '',
            ),
            date: '',
            time: '',
            venue: Venue(
              timestamp: '',
              ranking: '',
              nameOfVenue: '',
              locationOfVenue: '',
              plusCode: '',
              typeOfVenue: [],
              numberOfReviews: '',
              serviceOptions: [],
              accessabilityOptions: [],
              rating: '',
              parkingSpace: '',
              numberOfSubhalls: '',
              city: '',
              totalHallsCapacity: '',
              refundPolicy: [],
              contactNumber: '',
              websiteLink: '',
              pricePerPerson: 0,
              description: '',
              arEnabled: false,
              paranomaEnabled: false,
              verifiedStatus: false,
              images: [],
              wifi: false,
              wifiCost: 0,
              subVenues: [],
              reviews: [],
            ),
            subVenue: SubVenue(
                nameOfSubVenue: '',
                capacityOfSubVenue: 0,
                availableDates: [],
                bookingCharges: [],
                menuOptions: [],
                decorOptions: []),
            guestCount: 0,
            selectedOptions: [],
            selectedDates: [],
            totalAmount: 0,
            status: ''),
      );
    }
    return null;
  }
}
