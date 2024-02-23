import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getIsDarkTheme =>
      Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get getColor =>
      getIsDarkTheme ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
