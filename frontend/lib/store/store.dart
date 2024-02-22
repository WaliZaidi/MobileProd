import '../models/venue_model.dart'; // Import the models.dart file
import '../services/mobile_API.dart' as api; // Import your api.dart file

class AppDataStore {
  static List<Venue> dataList = [];
  static Venue? currentVenue;
  static List<Venue> filteredVenues = [];

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

  


  static Future<List<Venue>> fetchFilteredData(
    List<String> selectedRating,
    List<String> selectedTypeOfVenue,
    List<String> selectedCity,
    List<String> selectedPricePerPerson,
    List<String> selectedAccessibilityOptions,
    List<String> selectedCapacity,
    List<String> selectedRefundPolicy,
  ) async {
    List<String> venueNames = [''];
    venueNames = await api.filteredData(selectedRating, selectedTypeOfVenue, selectedCity, selectedPricePerPerson, selectedAccessibilityOptions, selectedCapacity, selectedRefundPolicy);
    if (venueNames.isNotEmpty) {
        List<Venue> filteredDataVenues = dataList.where((venue) => venueNames.contains(venue.nameOfVenue)).toList();
        filteredVenues = filteredDataVenues;

      return filteredVenues;
    }
    else {
      List<Venue> filteredData = dataList.where((venue) {
        bool ratingMatches = selectedRating.isEmpty || selectedRating.contains(venue.rating);
        bool typeMatches = selectedTypeOfVenue.isEmpty || selectedTypeOfVenue.contains(venue.typeOfVenue.join(', '));
        bool cityMatches = selectedCity.isEmpty || selectedCity.contains(venue.city);
        bool priceMatches = selectedPricePerPerson.isEmpty || selectedPricePerPerson.contains(venue.pricePerPerson as int);
        bool accessibilityMatches = selectedAccessibilityOptions.isEmpty || selectedAccessibilityOptions.any((option) => venue.accessabilityOptions.contains(option));
        bool capacityMatches = selectedCapacity.isEmpty || selectedCapacity.contains(venue.totalHallsCapacity as int);
        bool refundPolicyMatches = selectedRefundPolicy.isEmpty || selectedRefundPolicy.contains(venue.refundPolicy.join(', '));

        return ratingMatches && typeMatches && cityMatches && priceMatches && accessibilityMatches && capacityMatches && refundPolicyMatches;
      }).toList();

      filteredVenues = filteredData;

      return filteredData;
    }
  }
}