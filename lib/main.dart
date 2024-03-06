import 'package:flutter/material.dart';
import 'package:flutter_first_app/consts/theme_data.dart';
import 'package:flutter_first_app/providers/api_client.dart';
import 'package:flutter_first_app/providers/auth_provider.dart';
import 'package:flutter_first_app/providers/categories_provider.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:flutter_first_app/screens/auth_screen.dart';
import 'package:flutter_first_app/screens/navbar_screen.dart';
import 'package:flutter_first_app/services/storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<StorageService>(
            create: (_) => StorageService(),
          ),
          ChangeNotifierProxyProvider<StorageService, UserProvider>(
            create: (context) => UserProvider(Provider.of<StorageService>(
                context,
                listen: false)), // Now passing StorageService to UserProvider
            update: (context, storageService, previousUserProvider) =>
                UserProvider(storageService),
          ),
          ProxyProvider<UserProvider, ApiClient>(create: (context) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            return ApiClient(userProvider: userProvider);
          }, update: (context, userProvider, previousApiClient) {
            return ApiClient(userProvider: userProvider);
          }),
          ChangeNotifierProxyProvider<UserProvider, CategoriesProvider>(
            create: (context) => CategoriesProvider(
                '', Provider.of<ApiClient>(context, listen: false)),
            update: (context, userProvider, previousCategoriesProvider) =>
                CategoriesProvider(userProvider.user?.token ?? '',
                    Provider.of<ApiClient>(context)),
          ),
          ChangeNotifierProvider(
            create: (_) {
              return themeChangeProvider;
            },
          ),
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          bool isAuthenticated = authProvider.isAuthenticated;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grociphy',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: isAuthenticated ? NavbarScreen() : AuthScreen(),
          );
        }));
  }
}
