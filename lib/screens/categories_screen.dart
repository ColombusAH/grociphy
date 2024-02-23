import 'package:flutter/material.dart';
import 'package:flutter_first_app/services/utils.dart';
import 'package:flutter_first_app/widgets/categories_widget.dart';
import 'package:flutter_first_app/widgets/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.orange
  ];
  List<Map<String, dynamic>> categories = [
    {'catText': 'Fruits', 'imgPath': 'assets/images/red-apple.png'},
    {'catText': 'Vegetables', 'imgPath': 'assets/images/red-apple.png'},
    {'catText': 'Bakery', 'imgPath': 'assets/images/red-apple.png'},
    {'catText': 'Dairy', 'imgPath': 'assets/images/red-apple.png'},
    {'catText': 'Meat', 'imgPath': 'assets/images/red-apple.png'},
    {'catText': 'Seafood', 'imgPath': 'assets/images/red-apple.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.getColor;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: TextWidget(
              text: 'Categories',
              color: color,
              textSize: 24,
              isTitle: true,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: List.generate(6, (index) {
              return CategoriesWidget(
                catText: categories[index]['catText'],
                imgPath: categories[index]['imgPath'],
                color: colors[index],
              );
            }),
          ),
        ));
  }
}
