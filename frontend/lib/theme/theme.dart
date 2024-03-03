// import 'package:flutter/material.dart';

// // Define the theme for our own card
// ThemeData theme = ThemeData(
//   // Define the card's background color
//   cardColor: Colors.white,

//   // Define the card's border
//   cardTheme: CardTheme(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//   ),

//   // Define the card's shadow color
//   shadowColor: Colors.grey[300],

//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(Colors.red),
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//     ),
//   ),
//   // Define the card's text style
//   textTheme: TextTheme(
//     titleLarge: const TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.bold,
//     ),
//     bodyMedium: TextStyle(
//       fontSize: 14.0,
//       color: Colors.grey[600],
//     ),
//   ),

//   // Set padding for dialogues to zero
//   dialogTheme: DialogTheme(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(30.0),
//     ),
//   ),

//   appBarTheme: const AppBarTheme(
//     color: Colors.white,
//     elevation: 0,
//     iconTheme: IconThemeData(
//       color: Colors.black,
//     ),
//   ),
// );

// // Define the theme for our own card
// import 'package:flutter/material.dart';

// // Define the theme for our own card
// ThemeData theme = ThemeData(
//   // Define the card's background color
//   cardColor: Colors.white,

//   primaryColor: Colors.white,
//   secondaryHeaderColor: Colors.red,

//   // Define the card's border
//   cardTheme: CardTheme(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//   ),

//   // Define the card's shadow color
//   shadowColor: Colors.grey[300],

//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(Colors.red),
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//     ),
//   ),
//   // Define the card's text style
//   textTheme: TextTheme(
//     headline6: const TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.bold,
//     ),
//     bodyText2: TextStyle(
//       fontSize: 14.0,
//       color: Colors.grey[600],
//     ),
//   ),

//   // Set padding for dialogues to zero
//   dialogTheme: DialogTheme(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(30.0),
//     ),
//   ),

//   appBarTheme: const AppBarTheme(
//     color: Colors.white,
//     elevation: 0,
//     iconTheme: IconThemeData(
//       color: Colors.black,
//     ),
//   ),

//   //i want to change the theme for textfield
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide:
//           BorderSide(color: Colors.red), // Change border color when focused
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//   ),
// );

import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.red,
        secondary: Colors.red,
      ),
      primaryColor: Colors.white,
      secondaryHeaderColor: Colors.red,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          color: Colors.grey[600],
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
