import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants/constant.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    unselectedWidgetColor: const Color(0xffe2e2e2),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: shimmerLightGreen,
    ),
    dividerTheme: const DividerThemeData(color: Colors.grey),
    colorScheme: ColorScheme.light(
        secondary: shimmerLightGreen,
        background: Colors.white,
        primary: Colors.black,
        onPrimary: const Color(0xff417a04),
        onSecondary: Colors.black54,
        primaryContainer: Colors.red,
        secondaryContainer: const Color(0xffe4e4e4),
        brightness: Brightness.light,
        onSecondaryContainer: const Color(0xffc6c6c6),
        onPrimaryContainer: Colors.black12,
        onBackground: Colors.black,
        surface: const Color(0xfff4f4f4)),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Colors.black26,
      activeTrackColor: green,
      trackShape: const RectangularSliderTrackShape(),
      trackHeight: 3.0,
      thumbColor: green,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: green,
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 8.0),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.black26,
      textColor: Colors.black,
    ),
    dialogBackgroundColor: Colors.white,
    dialogTheme: const DialogTheme(
      /// by default white
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      backgroundColor: Colors.white,

    ),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        /// BackGround color by default ColorScheme.primary
        foregroundColor: Colors.white, backgroundColor: Colors.black,
      ),
    ),
    textTheme: TextTheme(
        headline1: h1StyleLight, headline2: h2StyleLight, headline3: h3StyleLight, headline4: h4StyleLight, headline5: h5StyleLight),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        filled: true,
        fillColor: const Color(0xffd0d0d0),
        hoverColor: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Color(0xff417a04)),
      unselectedIconTheme: IconThemeData(color: Colors.black),
      selectedItemColor: Color(0xff417a04),
      unselectedItemColor: Colors.black,
    ),
  );

  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    unselectedWidgetColor: const Color(0xff292929),
    appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Colors.black, titleTextStyle: TextStyle(fontSize: 18)),
    dividerTheme: const DividerThemeData(color: Colors.white),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: shimmerLightGreen,
    ),
    colorScheme: ColorScheme.dark(
      background: const Color(0xff292929),
      primary: Colors.white,
      onPrimary: const Color(0xff417a04),
      secondary: shimmerLightGreen,
      onSecondary: Colors.white,
      primaryContainer: Colors.red,
      secondaryContainer: const Color(0xff292929),
      onSecondaryContainer: const Color(0xff292929),
      onPrimaryContainer: const Color(0xff292929),
      onBackground: Colors.white,
      surface: const Color(0xff6f6f6f),
      brightness: Brightness.dark,
    ),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Colors.white24,
      activeTrackColor: green,
      trackShape: const RectangularSliderTrackShape(),
      trackHeight: 3.0,
      thumbColor: green,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: green,
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 8.0),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white24,
      textColor: Colors.white,
    ),
    dialogBackgroundColor: const Color(0xff292929),

    /// by default black
    dialogTheme: DialogTheme(titleTextStyle: TextStyle(color: Colors.white, fontSize: 15.sp), backgroundColor: const Color(0xff6f6f6f)),
    dividerColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme:
        TextTheme(headline1: h1StyleDark, headline2: h2StyleDark, headline3: h3StyleDark, headline4: h4StyleDark, headline5: h5StyleDark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.red, backgroundColor: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Color(0xff417a04)),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      selectedItemColor: Color(0xff417a04),
      unselectedItemColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: const Color(0xff6f6f6f),
      filled: true,
      fillColor: const Color(0xff2C3239),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6.0),
      ),
    ),
  );
}

TextStyle h1StyleLight = TextStyle(fontSize: 17.5.sp, color: const Color(0xff101010), fontFamily: 'Poppins-Regular');
TextStyle h2StyleLight = TextStyle(
  fontSize: 15.sp,
  fontFamily: "Poppins-Regular",
  color: const Color(0xff525252),
);

TextStyle h3StyleLight =
    TextStyle(color: const Color(0xffcacaca), fontFamily: "Poppins-Regular", fontSize: 20.sp, fontWeight: FontWeight.normal);

TextStyle h4StyleLight = TextStyle(fontSize: 15.sp, color: const Color(0xff2d2d2d), fontFamily: "Poppins-Regular");

TextStyle h5StyleLight = TextStyle(fontSize: 18.sp, color: Colors.black, fontFamily: "Poppins-Bold");

/// Dark Mode
TextStyle h1StyleDark = TextStyle(fontSize: 17.5.sp, color: const Color(0xfff0f0f0), fontFamily: 'Poppins-Regular');

TextStyle h2StyleDark = TextStyle(fontSize: 15.sp, color: const Color(0xffc5c5c5), fontFamily: "Poppins-Regular");

TextStyle h3StyleDark =
    TextStyle(color: const Color(0xffabacac), fontFamily: "Poppins-Regular", fontSize: 20.sp, fontWeight: FontWeight.normal);
TextStyle h4StyleDark = TextStyle(fontSize: 15.sp, color: const Color(0xff949494), fontFamily: "Poppins-Regular");
TextStyle h5StyleDark = TextStyle(fontSize: 18.sp, color: const Color(0xff00ff89), fontFamily: "Poppins-Bold");
