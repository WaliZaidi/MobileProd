// import 'package:flutter/material.dart';

// class PropertyTypeList extends StatefulWidget {
//   const PropertyTypeList({Key? key}) : super(key: key);

//   @override
//   State<PropertyTypeList> createState() => _PropertyTypeListState();
// }

// class _PropertyTypeListState extends State<PropertyTypeList> {
//   int selectedIndex = 0;

//   void showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 1), // Adjust the duration as needed
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final textTheme = Theme.of(context).textTheme;

//     final List<Map<String, dynamic>> propertyTypes = [
//       {'type': 'Hotel', 'icon': Icons.hotel},
//       {'type': 'Apartment', 'icon': Icons.apartment},
//       {'type': 'BnB', 'icon': Icons.bedroom_child},
//       {'type': 'Villa', 'icon': Icons.villa},
//       {'type': 'Resort', 'icon': Icons.holiday_village},
//       {'type': 'Hostel', 'icon': Icons.hotel_outlined},
//     ];

//     return SizedBox(
//       height: 60.0,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: List.generate(
//             propertyTypes.length,
//             (index) => GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//                 showMessage('Selected: ${propertyTypes[index]['type']}');
//               },
//               child: Container(
//                 width: size.width * 0.25,
//                 margin: const EdgeInsets.only(
//                   right: 3.0,
//                   left: 4.0,
//                   top: 4.0,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(propertyTypes[index]['icon']),
//                     const SizedBox(height: 2.0),
//                     Text(
//                       propertyTypes[index]['type'],
//                       style: textTheme.bodyMedium!.copyWith(
//                         fontWeight: (index == selectedIndex)
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                       ),
//                     ),
//                     if (index == selectedIndex)
//                       Container(
//                         margin: const EdgeInsets.only(top: 8.0),
//                         height: 2.0,
//                         width: 80.0,
//                         color: Colors.black,
//                       )
//                     else
//                       const SizedBox(height: 8.0)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PropertyTypeList extends StatefulWidget {
  const PropertyTypeList({Key? key}) : super(key: key);

  @override
  State<PropertyTypeList> createState() => _PropertyTypeListState();
}

class _PropertyTypeListState extends State<PropertyTypeList> {
  int selectedIndex = 0;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1), // Adjust the duration as needed
        backgroundColor: Color.fromARGB(255, 217, 48, 45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final List<Map<String, dynamic>> propertyTypes = [
      {'type': 'Hotel', 'icon': Icons.hotel},
      {'type': 'Apartment', 'icon': Icons.apartment},
      {'type': 'BnB', 'icon': Icons.bedroom_child},
      {'type': 'Villa', 'icon': Icons.villa},
      {'type': 'Resort', 'icon': Icons.holiday_village},
      {'type': 'Hostel', 'icon': Icons.hotel_outlined},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / propertyTypes.length + 5.0;

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
              },
              child: Container(
                width: itemWidth,
                margin: const EdgeInsets.only(
                  right: 3.0,
                  left: 4.0,
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
