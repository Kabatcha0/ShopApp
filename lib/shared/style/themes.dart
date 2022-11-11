import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/shared/style/const.dart';

ThemeData theme = ThemeData(
  primarySwatch: primary,
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText2: TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: primary),
    elevation: 0.0,
    // toolbarTextStyle: TextStyle(color: Colors.black),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: primary),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 55,
      selectedItemColor: primary,
      type: BottomNavigationBarType.fixed),
);
ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      // toolbarTextStyle: TextStyle(color: Colors.black),
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: primary),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light),
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        bodyText2: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 55,
        unselectedItemColor: Colors.white,
        selectedItemColor: primary,
        type: BottomNavigationBarType.fixed));
