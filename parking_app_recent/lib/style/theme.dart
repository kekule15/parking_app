
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/style/appColors.dart';
import 'package:parking_app/utils/temporary_storage.dart';

final themeDataProvider =
    ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());

class ThemeProvider extends ChangeNotifier {
  final String key = "theme";

  bool? isdarkTheme;
  bool get mydarkTheme => isdarkTheme!;

  ThemeProvider() {
    isdarkTheme = false;
    _loadFromPrefs();
  }
  toggleTheme() {
    isdarkTheme = !isdarkTheme!;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    isdarkTheme = await LocalStorageManager.getBool(key: key);

    notifyListeners();
  }

  _saveToPrefs() async {
    LocalStorageManager.setBool(key: key, value: isdarkTheme);
    // themeBox.write(key, isdarkTheme!);
  }

  ThemeData darkTheme = ThemeData.dark().copyWith(
    //  primarySwatch: createMaterialColor(AppColors.lightGold),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.primary,
      secondary: AppColors.dropDownBorderColor,
      onSecondary: AppColors.dropDownBorderColor,
      error: AppColors.primary,
      onError: AppColors.primary,
      background: AppColors.black,
      onBackground: AppColors.black,
      surface: AppColors.termsTextColor,
      onSurface: AppColors.termsTextColor,
    ),
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,
    disabledColor: AppColors.primary.withOpacity(0.3),
    dialogBackgroundColor: AppColors.termsTextColor,
    dialogTheme: DialogTheme(
        backgroundColor: AppColors.termsTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
    cardTheme: CardTheme(
        color: AppColors.termsTextColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1))),
    drawerTheme:
        const DrawerThemeData(backgroundColor: AppColors.termsTextColor),
    scaffoldBackgroundColor: AppColors.black,
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      // thumbVisibility: true,
      radius: const Radius.circular(2.0),
      thumbColor: MaterialStateProperty.all(
        AppColors.primary,
      ),
      trackColor: MaterialStateProperty.all(
        AppColors.white,
      ),
      //trackVisibility: true,
      thickness: MaterialStateProperty.all(6.0),
      minThumbLength: 100,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: AppColors.termsTextColor,
      iconColor: AppColors.white,
      collapsedIconColor: AppColors.white,
      collapsedBackgroundColor: AppColors.black,
      textColor: AppColors.white,
      collapsedTextColor: AppColors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.termsTextColor,
      filled: true,
      errorMaxLines: 4,
      errorStyle: const TextStyle(
        letterSpacing: -0.4,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.dropDownBorderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      hintStyle: const TextStyle().copyWith(
        color: AppColors.dropDownBorderColor,
        //fontWeight: FontWeight.w600,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: AppColors.white,
    // fontFamily: 'Sofia Pro',
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      color: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    textTheme: TextTheme(
      headlineSmall: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      headlineMedium: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      displaySmall: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontSize: 21,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
    ),
    primaryTextTheme: TextTheme(
      headlineSmall: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1),
      headlineMedium: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1),
      displaySmall: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontSize: 21,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.termsTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.primary),
    canvasColor: AppColors.dropDownBorderColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.dropDownBorderColor,
        selectedIconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.dropDownBorderColor,
        )),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Colors.transparent),
        checkColor: MaterialStateProperty.all(AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: AlwaysActiveBorderSide()),
    //colorScheme: ColorScheme(background: AppColors.black)
  );

  ThemeData lightTheme = ThemeData.light().copyWith(
      // primarySwatch: createMaterialColor(AppColors.primary),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.primary,
        secondary: AppColors.dropDownBorderColor,
        onSecondary: AppColors.dropDownBorderColor,
        error: AppColors.primary,
        onError: AppColors.primary,
        background: AppColors.white,
        onBackground: AppColors.white,
        surface: AppColors.black,
        onSurface: AppColors.black,
      ),
      primaryColor: AppColors.primary,
      cardTheme: CardTheme(
          color: AppColors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1))),
      brightness: Brightness.light,
      dialogBackgroundColor: AppColors.white,
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),
      dialogTheme: DialogTheme(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      scaffoldBackgroundColor: AppColors.white,
      scrollbarTheme: ScrollbarThemeData(
        interactive: true,
        // isAlwaysShown: true,
        radius: const Radius.circular(2.0),
        thumbColor: MaterialStateProperty.all(
          AppColors.primary,
        ),
        trackColor: MaterialStateProperty.all(
          AppColors.scrollTrack,
        ),
        // showTrackOnHover: true,
        thickness: MaterialStateProperty.all(6.0),
        minThumbLength: 100,
      ),
      expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: AppColors.white,
          iconColor: AppColors.black,
          collapsedIconColor: AppColors.black,
          collapsedBackgroundColor: AppColors.white,
          textColor: AppColors.black,
          collapsedTextColor: AppColors.black,
          shape:
              Border(bottom: BorderSide(color: AppColors.black, width: 0.5))),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.termsTextColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.termsTextColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        hintStyle: const TextStyle().copyWith(
          color: AppColors.termsTextColor,
          //fontWeight: FontWeight.w400,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerColor: AppColors.termsTextColor,
      //fontFamily: 'Sofia Pro',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
           statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
           ),
        color: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: TextTheme(
        headlineSmall: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        headlineMedium: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.black,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        displaySmall: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.black,
          fontSize: 21,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.black,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
      ),
      primaryTextTheme: TextTheme(
        headlineSmall: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.textBlack,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        headlineMedium: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.textBlack,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        displaySmall: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.textBlack,
          fontSize: 21,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.textBlack,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: const TextStyle().copyWith(
          fontFamily: 'Poppins',
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
      disabledColor: AppColors.primary.withOpacity(0.5),
      iconTheme: const IconThemeData(color: AppColors.black),
      buttonTheme: const ButtonThemeData(buttonColor: AppColors.black),
      canvasColor: AppColors.termsTextColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.termsTextColor,
          selectedIconTheme: IconThemeData(
            color: AppColors.primary,
          ),
          unselectedIconTheme: IconThemeData(
            color: AppColors.termsTextColor,
          )),
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(AppColors.white),
          checkColor: MaterialStateProperty.all(AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: AlwaysActiveBorderSide()));
}

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(states) =>
      const BorderSide(color: AppColors.primary, width: 1);
}
