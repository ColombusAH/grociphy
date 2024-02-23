import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/cart_screen.dart';
import 'package:flutter_first_app/screens/categories_screen.dart';
import 'package:flutter_first_app/screens/home_screen.dart';
import 'package:flutter_first_app/screens/user.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final List<Map<String, dynamic>> _all_pages = [
    {'page': const HomeScreen()},
    {'page': CategoriesScreen()},
    {'page': const CartScreen()},
    {'page': const UserScreen()}
  ];

  final List<String> _titles = ['Home', 'Categories', 'Cart', 'User'];

  int _selectedIndex = 0;
  void _setSelectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_titles[_selectedIndex].toString()),
      // ),
      body: _all_pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _setSelectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon:
                  Icon(_selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: 'User'),
        ],
      ),
    );
  }
}
