import 'package:flutter/material.dart';

// Define the theme for our own card
ThemeData cardTheme = ThemeData(
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
);

// Define the theme for our own card

