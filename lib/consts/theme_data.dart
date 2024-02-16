import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context){
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      primaryColor: isDarkTheme ? Colors.white : Colors.black,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: isDarkTheme ? Colors.white : Colors.black,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      cardColor: isDarkTheme ? Colors.black : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.white,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light(),
      )
    );
  }
}