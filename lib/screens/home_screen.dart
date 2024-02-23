import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:flutter_first_app/services/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> carouselImages = [
    "assets/images/carousel/1.png",
    "assets/images/carousel/2.png",
    "assets/images/carousel/3.png"
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size hostSize = Utils(context).getScreenSize;
    return Scaffold(
      body: SizedBox(
          child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            carouselImages[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        autoplay: true,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
              color: Colors.grey, activeColor: Colors.cyan),
        ),
        // control: SwiperControl(
        // ),
      )),
    );
  }
}
