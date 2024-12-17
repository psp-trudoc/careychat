import 'package:flutter/material.dart';
import 'package:carey/core/constants/config.dart';
import 'package:carey/core/constants/size.dart';
import 'package:carey/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor().white,
      titleTextStyle: TextStyle(
        fontSize: SizeUnit.size16,
        fontWeight: FontWeight.w700,
        color: AppColor().bodyHeadlineText,
      ),
      iconTheme: IconThemeData(
        color: AppColor().black,
      ),
      titleSpacing: defaultPadding,
    ),
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: AppColor().white,
    cardColor: AppColor().white,
    primaryColor: primaryColorLight,
    primaryColorDark: AppColor().blue700,
    dialogBackgroundColor: AppColor().white,
    disabledColor: const Color(0xFFD4D4D8),
    tabBarTheme: TabBarTheme(
      indicatorColor: AppColor().white,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor().white,
      surfaceTintColor: AppColor().backgroundLight,
      modalBackgroundColor: AppColor().backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor().blue,
      brightness: Brightness.light,
      error: AppColor().red,
      background: AppColor().white,
    ),
    textTheme: GoogleFonts.manropeTextTheme(TextTheme(
      headlineLarge: TextStyle(
        fontSize: SizeUnit.size32,
        fontWeight: FontWeight.w900,
        color: AppColor().bodyHeadlineText,
      ),
      headlineMedium: TextStyle(
        fontSize: SizeUnit.size24,
        fontWeight: FontWeight.w700,
        color: AppColor().bodyHeadlineText,
      ),
      headlineSmall: TextStyle(
        fontSize: SizeUnit.size16,
        fontWeight: FontWeight.w800,
        color: AppColor().bodyHeadlineText,
        height: 1.75, // 28px line height equivalent
      ),
      bodySmall: TextStyle(
        fontSize: SizeUnit.size12,
        color: AppColor().bodyText,
        height: 1.70, // 20px line height equivalent
      ),
      bodyMedium: TextStyle(
        fontSize: SizeUnit.size14,
        color: AppColor().bodyText,
        height: 1.70, // 20px line height equivalent
      ),
      bodyLarge: TextStyle(
        fontSize: SizeUnit.size16,
        color: AppColor().bodyText,
        height: 1.60, // 20px line height equivalent
      ),
    )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor().borderColor, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        disabledBackgroundColor: AppColor().disabledBackgroundColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: kDefaultOutlineInputBorder,
      enabledBorder: kDefaultOutlineInputBorder,
      contentPadding: kTextFieldPadding,
      focusedBorder: kDefaultOutlineInputBorder.copyWith(
        borderSide: BorderSide(color: primaryColorLight, width: 1.0),
      ),
      errorBorder: kDefaultOutlineInputBorder.copyWith(
        borderSide: BorderSide(color: AppColor().error, width: 1.0),
      ),
      errorStyle: TextStyle(
        fontSize: SizeUnit.size12,
        color: AppColor().error,
        height: 1.70,
        fontWeight: FontWeight.bold,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColor().dividerColor,
    ),
  );

  static final darkTheme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor().black,
        iconTheme: IconThemeData(
          color: AppColor().white,
        ),
      ),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: AppColor().black,
      cardColor: AppColor().grey900,
      primaryColor: AppColor().blue600,
      primaryColorDark: AppColor().blue400,
      dialogBackgroundColor: AppColor().black,
      tabBarTheme: TabBarTheme(
        indicatorColor: AppColor().grey700,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColor().backgroundDark,
        surfaceTintColor: AppColor().backgroundDark,
        modalBackgroundColor: AppColor().backgroundDark,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor().blue,
        brightness: Brightness.dark,
        error: AppColor().red300,
        background: AppColor().black,
      ),
      textTheme: const TextTheme().apply(
        displayColor: AppColor().white,
        bodyColor: AppColor().white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ));
}
