import '../models/venue_model.dart'; // Import the models.dart file
import '../services/mobile_API.dart' as api; // Import your api.dart file

class AppDataStore {
  static List<Venue> dataList = [];
  static Venue? currentVenue;
  static List<Venue> filteredVenues = [];
  static UserInfo? currentUser;

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

  // static void filterVenues(
  //   String selectedRating,
  //   List<String> selectedTypeOfVenue,
  //   String selectedCity,
  //   int selectedPricePerPerson,
  //   List<String> selectedAccessibilityOptions,
  //   int selectedCapacity,
  //   List<String> selectedRefundPolicy,
  // ) {
  //   fetchFilteredData(
  //     selectedRating,
  //     selectedTypeOfVenue,
  //     selectedCity,
  //     selectedPricePerPerson,
  //     selectedAccessibilityOptions,
  //     selectedCapacity,
  //     selectedRefundPolicy,
  //   ).then((venueNames) {
  //     // Filter the venues based on the selected venue names
  //     filteredVenues = dataList.where((venue) {
  //       // Check if the venue's name is in the venueNames list
  //       return venueNames.contains(venue.nameOfVenue);
  //     }).toList();
  //   }).catchError((error) {
  //     print('Failed to fetch filtered data: $error');
  //     // Handle error
  //   });
  // }

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
}
