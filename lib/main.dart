import 'package:flutter/material.dart';
import 'package:flutter_first_app/consts/theme_data.dart';
import 'package:flutter_first_app/providers/api_client.dart';
import 'package:flutter_first_app/providers/auth_provider.dart';
import 'package:flutter_first_app/providers/categories_provider.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:flutter_first_app/providers/groups_provider.dart';
import 'package:flutter_first_app/screens/auth_screen.dart';
import 'package:flutter_first_app/screens/navbar_screen.dart';
import 'package:flutter_first_app/services/storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();
  final themeChangeProvider = DarkThemeProvider();
  final bool isDarkTheme = await themeChangeProvider.darkThemePrefs.getTheme();

  runApp(MyApp(
    storageService: storageService,
    isDarkTheme: isDarkTheme,
  ));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;
  final bool isDarkTheme;

  MyApp({required this.storageService, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider(create: (_) => UserProvider(storageService)),
        ChangeNotifierProvider(
            create: (_) => DarkThemeProvider()..setDarkTheme = isDarkTheme),
        ProxyProvider<UserProvider, ApiClient>(
          update: (_, userProvider, __) =>
              ApiClient(userProvider: userProvider),
          lazy: false,
        ),
        ChangeNotifierProxyProvider2<UserProvider, ApiClient,
            CategoriesProvider>(
          create: (context) => CategoriesProvider(context.read<ApiClient>()),
          update: (context, userProvider, apiClient, previous) =>
              CategoriesProvider(apiClient),
        ),
        ChangeNotifierProxyProvider<ApiClient, GroupsProvider>(
          create: (context) => GroupsProvider(context.read<ApiClient>()),
          update: (context, apiClient, previous) => GroupsProvider(apiClient),
        )
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grociphy',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: context.watch<UserProvider>().isAuthenticated
                ? NavbarScreen()
                : AuthScreen(),
          );
        },
      ),
    );
  }
}
