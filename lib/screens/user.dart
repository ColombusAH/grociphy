import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:flutter_first_app/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color _color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          _buildListTile(
              title: 'Profile',
              icon: IconlyBold.profile,
              subtitle: 'This is the user screen',
              trailingIcon: IconlyLight.arrowRight2,
              color: _color,
              onTap: () {}),
          _buildListTile(
              title: 'Address 2',
              icon: IconlyBold.bag,
              subtitle: 'This is the user screen',
              trailingIcon: IconlyLight.arrowRight2,
              color: _color,
              onTap: () {}),
          _buildListTile(
              title: 'Forgot Password',
              icon: IconlyBold.unlock,
              trailingIcon: IconlyLight.arrowRight2,
              color: _color,
              onTap: () {}),
          SwitchListTile(
            title: Text(
              'Theme',
               style: TextStyle(
                  color: themeState.getDarkTheme ? Colors.white : Colors.black),
            ),
            secondary: Icon(themeState.getDarkTheme
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onChanged: (bool value) {
              themeState.setDarkTheme = value;
            },
            value: themeState.getDarkTheme,
          ),
          _buildListTile(
              title: 'Logout',
              icon: IconlyBold.logout,
              trailingIcon: IconlyLight.arrowRight2,
              color: _color,
              onTap: () {})
        ],
      ),
    ));
  }

  Widget _buildListTile(
      {required String title,
      String? subtitle,
      required Color color,
      required IconData icon,
      required trailingIcon,
      required Function() onTap}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
  
      ),
      subtitle: TextWidget(
        text: subtitle ?? '',
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: Icon(trailingIcon),
      onTap: onTap,
    );
  }
}
