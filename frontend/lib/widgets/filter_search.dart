//----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import your custom theme here
import '../store/store.dart'; // Import your store.dart file  


class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String selectedRating;
  late String selectedTypeOfVenue;
  late String selectedCity;
  late String selectedPricePerPerson;
  late String selectedAccessibilityOptions;
  late String selectedCapacity;
  late String selectedRefundPolicy;


  @override
  void initState() {
    super.initState();
    selectedRating = '';
    selectedTypeOfVenue = '';
    selectedCity = '';
    selectedPricePerPerson = '';
    selectedAccessibilityOptions = '';
    selectedCapacity = '';
    selectedRefundPolicy = '';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomHalfHeight = screenHeight;

    return Theme(
      data: theme, // Apply your custom theme here
      child: Container(
        height: bottomHalfHeight,
        alignment: Alignment.bottomCenter,
        child: AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Options',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Rating',
                    options: ['1', '2', '3', '4', '5'],
                    selectedOption: selectedRating,
                    onSelect: (value) {
                      setState(() {
                        selectedRating = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Type of Venue',
                    options: ['Banquet Hall', 'Wedding', 'Birthday', 'Corporate Events', 'Birthday'],
                    selectedOption: selectedTypeOfVenue,
                    onSelect: (value) {
                      setState(() {
                        selectedTypeOfVenue = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'City',
                    options: ['Islamabad', 'Lahore', 'Peshawar'],
                    selectedOption: selectedCity,
                    onSelect: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Price Per Person',
                    options: ['0-1500', '1500-2000', '2000-2500', '2500-3000', '3500-4000', '4000-4500', '4500-5000', '5000+'],
                    selectedOption: selectedPricePerPerson,
                    onSelect: (value) {
                      setState(() {
                        selectedPricePerPerson = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Accessibility Options',
                    options: ['Wheelchair Access', 'Wheelchair Accessable Parking'],
                    selectedOption: selectedAccessibilityOptions,
                    onSelect: (value) {
                      setState(() {
                        selectedAccessibilityOptions = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Capacity',
                    options: ['0-50', '50-100', '100-200', '200-400', '400-600', '600-1000', '1000+' ],
                    selectedOption: selectedCapacity,
                    onSelect: (value) {
                      setState(() {
                        selectedCapacity = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Refund Policy',
                    options: ['Yes', 'No', 'Partial Refund'],
                    selectedOption: selectedCity,
                    onSelect: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedRating = '';
                      selectedTypeOfVenue = '';
                      selectedCity = '';
                      selectedPricePerPerson = '';
                      selectedAccessibilityOptions = '';
                      selectedCapacity = '';  
                      selectedRefundPolicy = '';
                      
                    });
                  },
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Filter the venues based on the selected filters
                    AppDataStore.filterVenues(
                      selectedRating: selectedRating,
                      selectedTypeOfVenue: selectedTypeOfVenue,
                      selectedCity: selectedCity,
                      selectedPricePerPerson: selectedPricePerPerson,
                      selectedAccessibilityOptions: selectedAccessibilityOptions,
                      selectedCapacity: selectedCapacity,
                      selectedRefundPolicy: selectedRefundPolicy,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilterOption({
    required String title,
    required List<String> options,
    required String selectedOption,
    required Function(String) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: FilterChip(
                  label: Text(option),
                  selected: selectedOption == option,
                  onSelected: (selected) {
                    onSelect(option);
                  },
                  selectedColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  checkmarkColor: Colors.white,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 0.8,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
