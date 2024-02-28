import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import your custom theme here
import '../store/store.dart'; // Import your store.dart file
import '../screens/search_results.dart';
import '../models/venue_model.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String selectedRatings;
  late String selectedTypeOfVenue;
  late String selectedCity;
  late String selectedPricePerPerson;
  late String selectedAccessibilityOptions;
  late String selectedCapacity;
  late String selectedRefundPolicy;

  @override
  void initState() {
    super.initState();
    selectedRatings = '';
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
                    selectedOption: selectedRatings,
                    onSelect: (value) {
                      setState(() {
                        selectedRatings = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Type of Venue',
                    options: [
                      'Banquet Hall',
                      'Wedding',
                      'Birthday',
                      'Corporate Events',
                      'Birthday'
                    ],
                    selectedOption: selectedTypeOfVenue,
                    onSelect: (value) {
                      setState(() {
                        if (selectedTypeOfVenue == '') {
                          selectedTypeOfVenue = value;
                        } else {
                          selectedTypeOfVenue += ', $value';
                        } //i just added this to check if it works
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
                    title: 'Max Price Per Person',
                    options: [
                      '1500',
                      '2000',
                      '2500',
                      '3000',
                      '4000',
                      '4500',
                      '5000',
                      '5000+'
                    ],
                    selectedOption: selectedPricePerPerson.toString(),
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
                    options: [
                      'Wheelchair Access',
                      'Wheelchair Accessible Parking'
                    ],
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
                    title: 'Max Capacity',
                    options: ['50', '100', '200', '400', '600', '1000', '1500'],
                    selectedOption: selectedCapacity,
                    onSelect: (value) {
                      setState(() {
                        selectedCapacity = value;
                        print(selectedCapacity);
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
                    selectedOption: selectedRefundPolicy,
                    onSelect: (value) {
                      setState(() {
                        selectedRefundPolicy = value;
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
                      selectedRatings = '';
                      selectedTypeOfVenue = '';
                      selectedCity = '';
                      selectedPricePerPerson = '';
                      selectedAccessibilityOptions = '';
                      selectedCapacity = '';
                      selectedRefundPolicy = '';
                    });
                    AppDataStore.clearFilteredVenues();
                  },
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Filter the venues based on the selected filters
                    AppDataStore.filterVenues(
                      selectedRatings,
                      selectedTypeOfVenue,
                      selectedCity,
                      selectedPricePerPerson,
                      selectedAccessibilityOptions,
                      selectedCapacity as int,
                      selectedRefundPolicy,
                    );
                    // Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SearchResults(dynamicModifier: 1)),
                    );
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
        const SizedBox(height: 15.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: options.map((option) {
              final isSelected = selectedOption == option;
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: FilterChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    onSelect(selected ? option : '');
                  },
                  selectedColor: Colors.black,
                  backgroundColor: isSelected
                      ? Colors.black.withOpacity(0.1)
                      : const Color.fromARGB(255, 255, 255, 255),
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
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
