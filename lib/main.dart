import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

// Color scheme for the light theme
var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);

// Color scheme for the dark theme
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 3, 54, 68));

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          // Dark theme configuration
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.primaryContainer,
                foregroundColor: kDarkColorScheme.onPrimaryContainer),
          ),
        ),
        theme: ThemeData().copyWith(
          // Light theme configuration
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
            centerTitle: true,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 18,
                ),
              ),
        ),
        themeMode: ThemeMode.system, // Use the system's theme (light or dark)
        home: Expenses()), // Set the home screen to the Expenses widget
  );
}
