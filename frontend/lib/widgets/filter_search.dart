// //----------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import '../theme/theme.dart'; // Import your custom theme here
// import '../store/store.dart'; // Import your store.dart file
// import '../screens/search_results.dart';

// class FilterWidget extends StatefulWidget {
//   const FilterWidget({Key? key}) : super(key: key);

//   @override
//   _FilterWidgetState createState() => _FilterWidgetState();
// }

// class _FilterWidgetState extends State<FilterWidget> {
//   late String selectedRating;
//   late String venueSelector = '';
//   late List<String> selectedTypeOfVenue;
//   late String selectedCity;
//   late int priceSelector = 0;
//   late int selectedPricePerPerson;
//   late String accessibilitySelector = '';
//   late List<String> selectedAccessibilityOptions;
//   late String selectedCapacity;
//   late String refundPolicySelector = '';
//   late List<String> selectedRefundPolicy;

//   @override
//   void initState() {
//     super.initState();
//     selectedRating = '';
//     selectedTypeOfVenue = [];
//     selectedCity = '';
//     selectedPricePerPerson = 0;
//     selectedAccessibilityOptions = [];
//     selectedCapacity = '';
//     selectedRefundPolicy = [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double bottomHalfHeight = screenHeight;

//     return Theme(
//       data: theme, // Apply your custom theme here
//       child: Container(
//         height: bottomHalfHeight,
//         alignment: Alignment.bottomCenter,
//         child: AlertDialog(
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(20.0),
//                   color: const Color.fromARGB(255, 255, 255, 255),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Filter Options',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(Icons.close),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'Rating',
//                     options: ['1', '2', '3', '4', '5'],
//                     selectedOptions: selectedRating,
//                     onSelect: (value) {
//                       setState(() {
//                         selectedRating = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'Type of Venue',
//                     options: [
//                       'Banquet Hall',
//                       'Wedding',
//                       'Birthday',
//                       'Corporate Events',
//                       'Birthday'
//                     ],
//                     selectedOptions: venueSelector,
//                     onSelect: (value) {
//                       setState(() {
//                         selectedTypeOfVenue.add(value);
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'City',
//                     options: ['Islamabad', 'Lahore', 'Peshawar'],
//                     selectedOptions: selectedCity,
//                     onSelect: (value) {
//                       setState(() {
//                         selectedCity = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'Price Per Person',
//                     options: [
//                       '0-1500',
//                       '1500-2000',
//                       '2000-2500',
//                       '2500-3000',
//                       '3500-4000',
//                       '4000-4500',
//                       '4500-5000',
//                       '5000+'
//                     ],
//                     selectedOptions: priceSelector.toString(),
//                     onSelect: (value) {
//                       setState(() {
//                         selectedPricePerPerson = priceSelector;
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'Accessibility Options',
//                     options: [
//                       'Wheelchair Access',
//                       'Wheelchair Accessable Parking'
//                     ],
//                     selectedOptions: accessibilitySelector,
//                     onSelect: (value) {
//                       setState(() {
//                         selectedAccessibilityOptions.add(value);
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'Capacity',
//                     options: [
//                       '0-50',
//                       '50-100',
//                       '100-200',
//                       '200-400',
//                       '400-600',
//                       '600-1000',
//                       '1000+'
//                     ],
//                     selectedOptions: selectedCapacity,
//                     onSelect: (value) {
//                       setState(() {
//                         selectedCapacity = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: buildFilterOption(
//                     title: 'Refund Policy',
//                     options: ['Yes', 'No', 'Partial Refund'],
//                     selectedOptions: refundPolicySelector,
//                     onSelect: (value) {
//                       setState(() {
//                         selectedRefundPolicy.add(value);
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),
//               ],
//             ),
//           ),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       selectedRating = '';
//                       selectedTypeOfVenue = [];
//                       selectedCity = '';
//                       selectedPricePerPerson = 0;
//                       selectedAccessibilityOptions = [];
//                       selectedCapacity = '';
//                       selectedRefundPolicy = [];
//                     });
//                   },
//                   child: const Text('Clear'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Filter the venues based on the selected filters
//                     AppDataStore.filterVenues(
//                       selectedRating,
//                       selectedTypeOfVenue,
//                       selectedCity,
//                       selectedPricePerPerson,
//                       selectedAccessibilityOptions,
//                       selectedCapacity,
//                       selectedRefundPolicy,
//                     );
//                     // Navigator.of(context).pop();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SearchResults()),
//                     );
//                   },
//                   child: const Text('Search'),
//                 ),
//               ],
//             ),
//           ],
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(8.0),
//               topRight: Radius.circular(8.0),
//               bottomLeft: Radius.zero,
//               bottomRight: Radius.zero,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildFilterOption({
//     required String title,
//     required List<String> options,
//     required List<String> selectedOptions,
//     required Function(List<String>) onSelect,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16.0,
//             ),
//           ),
//         ),
//         const SizedBox(height: 15.0),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Row(
//             children: options.map((option) {
//               final isSelected = selectedOptions.contains(option);
//               return Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: FilterChip(
//                   label: Text(option),
//                   selected: isSelected,
//                   onSelected: (selected) {
//                     List<String> newSelectedOptions =
//                         List.from(selectedOptions);
//                     if (selected) {
//                       newSelectedOptions.add(option);
//                     } else {
//                       newSelectedOptions.remove(option);
//                     }
//                     onSelect(newSelectedOptions);
//                   },
//                   selectedColor: Colors.black,
//                   backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//                   checkmarkColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight:
//                         isSelected ? FontWeight.bold : FontWeight.normal,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     side: const BorderSide(
//                       color: Colors.grey,
//                       width: 0.8,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import your custom theme here
import '../store/store.dart'; // Import your store.dart file
import '../screens/search_results.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String selectedRatings;
  late List<String> selectedTypeOfVenue;
  late String selectedCity;
  late int selectedPricePerPerson;
  late List<String> selectedAccessibilityOptions;
  late String selectedCapacity;
  late List<String> selectedRefundPolicy;

  @override
  void initState() {
    super.initState();
    selectedRatings = '';
    selectedTypeOfVenue = [];
    selectedCity = '';
    selectedPricePerPerson = 0;
    selectedAccessibilityOptions = [];
    selectedCapacity = '';
    selectedRefundPolicy = [];
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
                    selectedOptions: [selectedRatings],
                    onSelect: (values) {
                      setState(() {
                        selectedRatings = values as String;
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
                    selectedOptions: selectedTypeOfVenue,
                    onSelect: (values) {
                      setState(() {
                        selectedTypeOfVenue = values;
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
                    selectedOptions: [selectedCity],
                    onSelect: (values) {
                      setState(() {
                        selectedCity = values.isNotEmpty ? values.first : '';
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Price Per Person',
                    options: [
                      '0-1500',
                      '1500-2000',
                      '2000-2500',
                      '2500-3000',
                      '3500-4000',
                      '4000-4500',
                      '4500-5000',
                      '5000+'
                    ],
                    selectedOptions: [selectedPricePerPerson.toString()],
                    onSelect: (values) {
                      setState(() {
                        selectedPricePerPerson =
                            int.tryParse(values.first) ?? 0;
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
                    selectedOptions: selectedAccessibilityOptions,
                    onSelect: (values) {
                      setState(() {
                        selectedAccessibilityOptions = values;
                      });
                    },
                  ),
                ),
                const Divider(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: buildFilterOption(
                    title: 'Capacity',
                    options: [
                      '0-50',
                      '50-100',
                      '100-200',
                      '200-400',
                      '400-600',
                      '600-1000',
                      '1000+'
                    ],
                    selectedOptions: [selectedCapacity],
                    onSelect: (values) {
                      setState(() {
                        selectedCapacity =
                            values.isNotEmpty ? values.first : '';
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
                    selectedOptions: selectedRefundPolicy,
                    onSelect: (values) {
                      setState(() {
                        selectedRefundPolicy = values;
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
                      selectedTypeOfVenue = [];
                      selectedCity = '';
                      selectedPricePerPerson = 0;
                      selectedAccessibilityOptions = [];
                      selectedCapacity = '';
                      selectedRefundPolicy = [];
                    });
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
                      selectedCapacity,
                      selectedRefundPolicy,
                    );
                    // Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchResults()),
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
    required List<String> selectedOptions,
    required Function(List<String>) onSelect,
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
              final isSelected = selectedOptions.contains(option);
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: FilterChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    List<String> newSelectedOptions =
                        List.from(selectedOptions);
                    if (selected) {
                      newSelectedOptions.add(option);
                    } else {
                      newSelectedOptions.remove(option);
                    }
                    onSelect(newSelectedOptions);
                  },
                  selectedColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
