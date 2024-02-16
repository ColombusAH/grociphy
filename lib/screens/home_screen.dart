import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Center(
          child: SwitchListTile(
        title: Text('Dark Mode', style: TextStyle(color: themeState.getDarkTheme ? Colors.white: Colors.black),),
        secondary: Icon(themeState.getDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
        onChanged: (bool value) {
          themeState.setDarkTheme = value;
        },
        value: themeState.getDarkTheme,
      )),
    );
  }
}
