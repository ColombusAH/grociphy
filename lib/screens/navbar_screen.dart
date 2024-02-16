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
  final List _pages = [HomeScreen(), CategoriesScreen(), CartScreen(), UserScreen()];
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _setSelectedPage,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: 'Home',),
        BottomNavigationBarItem(icon: Icon(IconlyLight.category), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(IconlyLight.buy), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(IconlyLight.user2), label: 'User'),
      ],),
    );
  }
}
