import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/categories_provider.dart';
import 'package:flutter_first_app/widgets/categories_widget.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.orange,
  ];
  late CategoriesProvider categoriesProvider;
  @override
  void initState() {
    super.initState();
    categoriesProvider =  Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.fetchCategories();
    categoriesProvider.startAutoRefresh();
  }

  @override
  void dispose() {
    categoriesProvider.stopAutoRefresh();
    super.dispose();
  }

  
 @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, categoriesProvider, child) => Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: List.generate(categoriesProvider.categories.length, (index) {
              final category = categoriesProvider.categories[index];
              // Use the modulo operator to cycle through the colors list
              Color color = colors[index % colors.length];
              // Assuming 'imgPath' might not exist, we use a placeholder
              String imgPath = category['imgPath'] ?? 'assets/images/red-apple.png';
              String catText = category['name'];

              return CategoriesWidget(
                catText: catText,
                imgPath: imgPath,
                color: color,
              );
            }),
          ),
        ),
      ),
    );
  }
}
  