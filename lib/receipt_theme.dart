import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// /// [ColorScheme] seed color
// Color _seedColor = const Color(0xFFB4E6FF);

/// Light and dark theme of app
class ReceiptTheme {
  /// Light Theme of app
  static ThemeData get light {
    return FlexThemeData.light(
      useMaterial3: true,
      scheme: _flexScheme,
      textTheme: GoogleFonts.poppinsTextTheme(_textTheme),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 20,
      appBarOpacity: 0.95,
      appBarElevation: 0.5,
      tooltipsMatchBackground: true,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendOnColors: false,
        unselectedToggleIsColored: true,
        popupMenuOpacity: 0.95,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationRailOpacity: 0.95,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    );
  }

  /// Dark Theme of app
  static ThemeData get dark {
    return FlexThemeData.dark(
      useMaterial3: true,
      scheme: _flexScheme,
      textTheme: GoogleFonts.poppinsTextTheme(_textTheme),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 20,
      appBarStyle: FlexAppBarStyle.background,
      appBarOpacity: 0.95,
      appBarElevation: 0.5,
      tooltipsMatchBackground: true,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 30,
        unselectedToggleIsColored: true,
        popupMenuOpacity: 0.95,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationRailOpacity: 0.95,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    );
  }
}

const _flexScheme = FlexScheme.flutterDash;

const TextTheme _textTheme = TextTheme(
  bodyLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
  ),
  headlineSmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    overflow: TextOverflow.ellipsis,
  ),
);

// final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
//   seedColor: _seedColor,
// );

// final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
//   seedColor: _seedColor,
//   brightness: Brightness.dark,
// );

// final ElevatedButtonThemeData _elevatedButtonThemeData =
//     ElevatedButtonThemeData(
//   style: ButtonStyle(
//     maximumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(6),
//       ),
//     ),
//     minimumSize: MaterialStateProperty.all(const Size(120, 40)),
//     padding:
//         MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24))
//   ),
// );

// final TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
//   style: ButtonStyle(
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//     ),
//     minimumSize: MaterialStateProperty.all(const Size(120, 40)),
//     padding:
//         MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24))
//   ),
// );

// final OutlinedButtonThemeData _outlinedButtonThemeData =
//     OutlinedButtonThemeData(
//   style: ButtonStyle(
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//     ),
//     minimumSize: MaterialStateProperty.all(const Size(120, 40)),
//     padding:
//         MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24))
//   ),
// );
