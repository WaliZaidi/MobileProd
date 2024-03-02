import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/venue_model.dart'; // Import the models.dart file

const String url = 'http://192.168.56.1:5000';

Future<List<Venue>> fetchData() async {
  final response = await http.get(Uri.parse('$url/query/search'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    // Assuming that jsonData is a list of venues
    final List<dynamic> venuesData = jsonData['venues'];

    // print(venuesData); this works, so that means its the conversion to Venue object that is the problem
    //check the structure of the first item

    print(venuesData[0]['nameOfVenue']);

    // Convert each venue data to a Venue object
    final List<Venue> venues = venuesData
        .map((venueData) => Venue(
              timestamp: venueData['timestamp'] ?? '',
              ranking: venueData['ranking'] ?? '',
              nameOfVenue: venueData['nameOfVenue'] ?? '',
              locationOfVenue: venueData['locationOfVenue'] ?? '',
              plusCode: venueData['plusCode'] ?? '',
              typeOfVenue: List<String>.from(venueData['typeOfVenue'] ?? []),
              numberOfReviews: venueData['numberOfReviews'] ?? '',
              serviceOptions:
                  List<String>.from(venueData['serviceOptions'] ?? []),
              accessabilityOptions:
                  List<String>.from(venueData['accessabilityOptions'] ?? []),
              rating: venueData['rating'] ?? '',
              parkingSpace: venueData['parkingSpace'] ?? '',
              numberOfSubhalls: venueData['numberOfSubhalls'] ?? '',
              city: venueData['city'] ?? '',
              totalHallsCapacity: venueData['totalHallsCapacity'] ?? '',
              refundPolicy: List<String>.from(venueData['refundPolicy'] ?? []),
              contactNumber: venueData['contactNumber'] ?? '',
              websiteLink: venueData['websiteLink'] ?? '',
              pricePerPerson: venueData['pricePerPerson'] ?? 0,
              description: venueData['description'] ?? '',
              arEnabled: venueData['arEnabled'] ?? false,
              paranomaEnabled: venueData['paranomaEnabled'] ?? false,
              verifiedStatus: venueData['verifiedStatus'] ?? false,
              images: (venueData['images'] as List<dynamic>?)
                      ?.map((imageData) => ImageUrl(
                            nameOfVenue: imageData['nameOfVenue'] ?? '',
                            link1: imageData['link1'] ?? '',
                            link2: imageData['link2'] ?? '',
                            link3: imageData['link3'] ?? '',
                            link4: imageData['link4'] ?? '',
                            link5: imageData['link5'] ?? '',
                          ))
                      .toList() ??
                  [],
              wifi: venueData['wifi'] ?? false,
              wifiCost: venueData['wifiCost'] ?? 0,
              subVenues: (venueData['subVenues'] as List<dynamic>?)
                      ?.map((subVenueData) => SubVenue(
                            nameOfSubVenue:
                                subVenueData['nameOfSubVenue'] ?? '',
                            capacityOfSubVenue:
                                subVenueData['capacityOfSubVenue'] ?? 0,
                            availableDates: (subVenueData['availableDates']
                                        as List<dynamic>?)
                                    ?.map((dateData) => AvailableDate(
                                          date: DateTime.parse(
                                              dateData['date'] ?? ''),
                                          startTime:
                                              dateData['startTime'] ?? '',
                                          endTime: dateData['endTime'] ?? '',
                                        ))
                                    .toList() ??
                                [],
                            menuOptions: (subVenueData['menuOptions']
                                        as List<dynamic>?)
                                    ?.map((menuOptionData) => MenuOption(
                                          packageName:
                                              menuOptionData['packageName'] ??
                                                  '',
                                          packageDescription: menuOptionData[
                                                  'packageDescription'] ??
                                              '',
                                          packageItems:
                                              (menuOptionData['packageItems']
                                                          as List<dynamic>?)
                                                      ?.map(
                                                          (packageItemData) =>
                                                              PackageItem(
                                                                itemCategoryName:
                                                                    packageItemData[
                                                                            'itemCategoryName'] ??
                                                                        '',
                                                                itemOptions: (packageItemData['itemOptions']
                                                                            as List<
                                                                                dynamic>?)
                                                                        ?.map((itemOptionData) =>
                                                                            ItemOption(
                                                                              itemName: itemOptionData['itemName'] ?? '',
                                                                            ))
                                                                        .toList() ??
                                                                    [],
                                                              ))
                                                      .toList() ??
                                                  [],
                                          packagePrice:
                                              menuOptionData['packagePrice'] ??
                                                  0,
                                        ))
                                    .toList() ??
                                [],
                            decorOptions: (subVenueData['decorOptions']
                                        as List<dynamic>?)
                                    ?.map((decorOptionData) => DecorOption(
                                          decorName:
                                              decorOptionData['decorName'] ??
                                                  '',
                                          forEventType:
                                              decorOptionData['forEventType'] ??
                                                  '',
                                          decorPrice:
                                              decorOptionData['decorPrice'] ??
                                                  0,
                                        ))
                                    .toList() ??
                                [],
                            bookingCharges: (subVenueData['bookingCharges']
                                        as List<dynamic>?)
                                    ?.map((bookingChargeData) => BookingCharge(
                                          bookingChargeName: bookingChargeData[
                                                  'bookingChargeName'] ??
                                              '',
                                          bookingChargePrice: bookingChargeData[
                                                  'bookingChargePrice'] ??
                                              0,
                                        ))
                                    .toList() ??
                                [],
                          ))
                      .toList() ??
                  [],
              reviews: (venueData['reviews'] as List<dynamic>?)
                      ?.map((reviewData) => Review(
                            nameOfVenue: reviewData['nameOfVenue'] ?? '',
                            totalScore:
                                reviewData['totalScore'].toDouble() ?? 0.0,
                            rating: reviewData['reviewRating'] ?? '',
                            stars: reviewData['stars'] ?? 0,
                            sentiment: reviewData['sentiment'] ?? '',
                            text: reviewData['text'] ?? '',
                          ))
                      .toList() ??
                  [],
            ))
        .toList();

    return venues;
  } else {
    // Handle errors
    print('Failed to load data');
    throw Exception('Failed to load data');
  }
}

Future<List<String>> fetchFilteredData(
  String selectedRating,
  String selectedTypeOfVenue,
  String selectedCity,
  String selectedPricePerPerson,
  String selectedAccessibilityOptions,
  String selectedCapacity,
  String selectedRefundPolicy,
) async {
  String urlSend = Uri.http(
    url.split('//')[1],
    '/query/search/name',
    {
      'rating': selectedRating,
      'typeOfVenue': selectedTypeOfVenue,
      'city': selectedCity,
      'pricePerPerson': selectedPricePerPerson,
      'totalHallsCapacity': selectedCapacity,
      'refundPolicy': selectedRefundPolicy,
      'accessabilityOptions': selectedAccessibilityOptions,
    },
  ).toString();

  final response = await http.get(Uri.parse(urlSend));
  print(response.body);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> venueNamesDynamic = jsonData['venues'];
    final List<String> venueNames =
        venueNamesDynamic.map((e) => e.toString()).toList();

    return venueNames;
  }

  throw Exception('Failed to load data');
}
