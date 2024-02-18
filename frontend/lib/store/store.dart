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

  static void filterVenues({
    String selectedRating = '',
    String selectedTypeOfVenue = '',
    String selectedCity = '',
    String selectedPricePerPerson = '',
    String selectedAccessibilityOptions = '',
    String selectedCapacity = '',
    String selectedRefundPolicy = '',
  }) {
    // Filter the venues based on the selected filters
    filteredVenues = dataList.where((venue) {
      final ratingMatches = venue.rating == selectedRating;
      final typeOfVenueMatches = venue.typeOfVenue.contains(selectedTypeOfVenue);
      final cityMatches = venue.city == selectedCity;
      final pricePerPersonMatches = venue.pricePerPerson == int.parse(selectedPricePerPerson);
      final accessibilityOptionsMatches = venue.accessabilityOptions.contains(selectedAccessibilityOptions);
      final capacityMatches = venue.totalHallsCapacity == selectedCapacity;
      final refundPolicyMatches = venue.refundPolicy.contains(selectedRefundPolicy);

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
