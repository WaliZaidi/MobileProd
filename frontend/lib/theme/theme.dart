import 'package:flutter/material.dart';

// Define the theme for our own card
ThemeData theme = ThemeData(
  // Define the card's background color
  cardColor: Colors.white,

  // Define the card's border
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Define the card's shadow color
  shadowColor: Colors.grey[300],

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
  // Define the card's text style
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.grey[600],
    ),
  ),

  // Set padding for dialogues to zero
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
);

// Define the theme for our own card
