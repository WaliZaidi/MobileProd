// import 'dart:convert';

// import '../services/mobile_API.dart'; // Import your api.dart file

// class AppDataStore {
//   static List<Map<String, dynamic>> dataList = [];
//   static Map<String, dynamic>? currentVenue;

//   // static Future<void> fetchDataAtAppLaunch() async {
//   //   try {
//   //     final List<Map<String, dynamic>> jsonData = await fetchData();

//   //     dataList = jsonData;
//   //   } catch (e) {
//   //     // Handle exceptions
//   //     print('Exception: $e');
//   //   }
//   // }

//   static Future<void> fetchDataAtAppLaunch() async {
//     try {
//       final List<Map<String, dynamic>> venues = await fetchData();

//       // Print raw JSON data
//       print('Raw JSON data: $venues');

//       // Check the structure of the first item
//       if (venues.isNotEmpty) {
//         final firstItem = venues[0];
//         print('Structure of the first item: $firstItem');
//       }

//       dataList = venues;
//     } catch (e) {
//       // Handle exceptions
//       print('Exception: $e');
//     }
//   }

//   static void selectVenue(int index) {
//     currentVenue = dataList.isNotEmpty ? dataList[index] : null;
//     // You can perform additional actions when a venue is selected, such as fetching secondary information.
//   }

//   static void selectVenueByName(String venueName) {
//     // Trim whitespace from the input venueName
//     venueName = venueName.trim();

//     // Check if venueName is empty
//     if (venueName.isEmpty) {
//       print('Venue name is empty');
//       return;
//     }

//     // Debugging: Print the values during the search process
//     print('Searching for: $venueName');

//     final currentChecking = dataList[0];

//     final currentChecking2 = json.decode(currentChecking.toString());

//     print('DataListChecking1: $currentChecking');
//     print('DataListChecking2: $currentChecking2');
//     // print('DataListChecking2: $dataList[1]');
//     // print('DataListChecking3: $dataList[2].nameOfVenue');
//     // print('DataListChecking4: ${dataList[2]['nameOfVenue']}');
//     // print('DataListChecking5: ${dataList[2]['nameOfVenue']?.trim()}');
//     // print('DataListChecking6: ${dataList[0][0]}');
//     // print('DataListChecking7: ${dataList[0][1].nameOfVenue}');

//     // for (var venue in dataList) {
//     //   print('Venue in list: ${venue['nameOfVenue']}');
//     // }

//     // Search for the venue in dataList
//     // final venueIndex = dataList.indexWhere(
//     //   (venue) => (venue['nameOfVenue']?.trim() ?? '') == venueName,
//     // );
//     // var venueIndex = 0;

//     // for (var i = 0; i < dataList.length; i++) {
//     //   if ((dataList[i]['nameOfVenue']?.trim() ?? '') == venueName) {
//     //     print('Venue found at index: $i');
//     //     venueIndex = i;
//     //     selectVenue(i);
//     //     return;
//     //   }
//     // }

//     // // Check if the venue was found
//     // if (venueIndex != -1) {
//     //   currentVenue = dataList[venueIndex];
//     //   print('Current Venue: $currentVenue');
//     // } else {
//     //   print('Venue not found');
//     // }
//   }
// }

import 'dart:convert';
import '../models/venue_model.dart'; // Import the models.dart file
import '../services/mobile_API.dart'; // Import your api.dart file

class AppDataStore {
  static List<Venue> dataList = [];
  static Venue? currentVenue;

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
}
