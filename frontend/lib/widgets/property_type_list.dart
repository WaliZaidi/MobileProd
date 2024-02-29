import 'package:flutter/material.dart';
import '../store/store.dart';
import '../screens/search_results.dart';

class PropertyTypeList extends StatefulWidget {
  const PropertyTypeList({Key? key}) : super(key: key);

  @override
  State<PropertyTypeList> createState() => _PropertyTypeListState();
}

class _PropertyTypeListState extends State<PropertyTypeList> {
  int selectedIndex = 0;

  late String selectedRatings;
  late String selectedTypeOfVenue;
  late String selectedCity;
  late String selectedPricePerPerson;
  late String selectedAccessibilityOptions;
  late String selectedCapacity;
  late String selectedRefundPolicy;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1), // Adjust the duration as needed
        backgroundColor: const Color.fromARGB(255, 217, 48, 45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final List<Map<String, dynamic>> propertyTypes = [
      {'type': 'Wedding', 'icon': Icons.favorite},
      {'type': 'Banquet', 'icon': Icons.meeting_room},
      {'type': 'Birthday', 'icon': Icons.cake},
      {'type': 'Corporate', 'icon': Icons.business_center},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 5;

    return SizedBox(
      height: 60.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            propertyTypes.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                showMessage('Selected: ${propertyTypes[index]['type']}');
                AppDataStore.filterVenues(
                  selectedRatings = '',
                  selectedTypeOfVenue = propertyTypes[index]['type'].toString(),
                  selectedCity = '',
                  selectedPricePerPerson = '',
                  selectedAccessibilityOptions = '',
                  selectedCapacity = '',
                  selectedRefundPolicy = '',
                );
                // Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SearchResults(dynamicModifier: 2)),
                );
              },
              child: Container(
                width: itemWidth,
                margin: const EdgeInsets.only(
                  right: 3.0,
                  left: 6.0,
                  top: 4.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(propertyTypes[index]['icon']),
                    const SizedBox(height: 2.0),
                    Text(
                      propertyTypes[index]['type'],
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: (index == selectedIndex)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    if (index == selectedIndex)
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        height: 2.0,
                        width: 80.0,
                        color: Colors.black,
                      )
                    else
                      const SizedBox(height: 8.0)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
