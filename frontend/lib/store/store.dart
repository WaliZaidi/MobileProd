import 'dart:convert';
import '../models/venue_model.dart'; // Import the models.dart file
import '../services/mobile_API.dart'; // Import your api.dart file

class AppDataStore {
  static List<Venue> dataList = [];
  static Venue? currentVenue;
  static List<Venue> filteredVenues = [];

  static Future<void> fetchDataAtAppLaunch() async {
    try {
      final jsonData = await fetchData();

      dataList = jsonData;
    } catch (e, stackTrace) {
      // Handle exceptions
      print('Exception: $e');
      //i want more details on the exception
      print('Exception: ${e.toString()}');
      //show me where this exception is coming from
      print('Exception: $stackTrace');
      print('Exception: ${stackTrace.toString()}');
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
    String selectedRating,
    List<String> selectedTypeOfVenue,
    String selectedCity,
    int selectedPricePerPerson,
    List<String> selectedAccessibilityOptions,
    String selectedCapacity,
    List<String> selectedRefundPolicy,
  ) {
    // Filter the venues based on the selected filters
    filteredVenues = dataList.where((venue) {
      // Check if the selectedRating is not empty and the venue's rating matches the selectedRating
      final ratingMatches =
          selectedRating.isNotEmpty ? venue.rating == selectedRating : true;

      // Check if the selectedTypeOfVenue is not empty and the venue's typeOfVenue matches the selectedTypeOfVenue
      final typeOfVenueMatches = selectedTypeOfVenue.isNotEmpty
          ? venue.typeOfVenue.any((type) => selectedTypeOfVenue.contains(type))
          : true;

      // Check if the selectedCity is not empty and the venue's city matches the selectedCity
      final cityMatches =
          selectedCity.isNotEmpty ? venue.city == selectedCity : true;

      // Check if the selectedPricePerPerson is not empty and the venue's pricePerPerson is less than or equal to the selectedPricePerPerson
      final pricePerPersonMatches = selectedPricePerPerson > 0
          ? venue.pricePerPerson <= selectedPricePerPerson
          : true;

      // Check if the selectedAccessibilityOptions is not empty and the venue's accessibilityOptions matches the selectedAccessibilityOptions
      final accessibilityOptionsMatches = selectedAccessibilityOptions
              .isNotEmpty
          ? venue.accessabilityOptions
              .any((option) => selectedAccessibilityOptions.contains(option))
          : true;

      // Check if the selectedCapacity is not empty and the venue's totalHallsCapacity matches the selectedCapacity
      final capacityMatches = selectedCapacity.isNotEmpty
          ? venue.totalHallsCapacity == selectedCapacity
          : true;

      // Check if the selectedRefundPolicy is not empty and the venue's refundPolicy matches the selectedRefundPolicy
      final refundPolicyMatches = selectedRefundPolicy.isNotEmpty
          ? venue.refundPolicy
              .any((policy) => selectedRefundPolicy.contains(policy))
          : true;

      // Return true if all the conditions are met
      return ratingMatches &&
          typeOfVenueMatches &&
          cityMatches &&
          pricePerPersonMatches &&
          accessibilityOptionsMatches &&
          capacityMatches &&
          refundPolicyMatches;
    }).toList();
  }
}
