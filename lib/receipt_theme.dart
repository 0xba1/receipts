import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Light and dark theme of app
class ReceiptTheme {
  /// Light Theme of app
  static ThemeData get light {
    return ThemeData(
      colorScheme: _lightColorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(_textTheme),
      elevatedButtonTheme: _elevatedButtonThemeData,
      textButtonTheme: _textButtonThemeData,
      outlinedButtonTheme: _outlinedButtonThemeData,
    );
  }

  /// Dark Theme of app
  static ThemeData get dark {
    return ThemeData(
      colorScheme: _darkColorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(_textTheme),
      elevatedButtonTheme: _elevatedButtonThemeData,
      textButtonTheme: _textButtonThemeData,
      outlinedButtonTheme: _outlinedButtonThemeData,
    );
  }
}

const TextTheme _textTheme = TextTheme(
  bodyText1: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  ),
  bodyText2: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  headline1: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
  headline2: TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
  ),
  headline3: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  subtitle1: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
  ),
  subtitle2: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    overflow: TextOverflow.ellipsis,
  ),
);

final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFC10000),
);

final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFC10000),
  brightness: Brightness.dark,
);

final ElevatedButtonThemeData _elevatedButtonThemeData =
    ElevatedButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    minimumSize: MaterialStateProperty.all(const Size(120, 40)),
    padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24)),
  ),
);

final TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    minimumSize: MaterialStateProperty.all(const Size(120, 40)),
    padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24)),
  ),
);

final OutlinedButtonThemeData _outlinedButtonThemeData =
    OutlinedButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    minimumSize: MaterialStateProperty.all(const Size(120, 40)),
    padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24)),
  ),
);
