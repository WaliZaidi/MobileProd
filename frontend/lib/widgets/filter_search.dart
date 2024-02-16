//----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import your custom theme here

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String selectedRating;
  late String selectedTypeOfVenue;
  late String selectedCity;

  @override
  void initState() {
    super.initState();
    selectedRating = '';
    selectedTypeOfVenue = '';
    selectedCity = '';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomHalfHeight = screenHeight / 1.5;

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
                    options: ['Option 1', 'Option 2', 'Option 3'],
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
                    options: ['City 1', 'City 2', 'City 3'],
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
                    });
                  },
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle search action
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
