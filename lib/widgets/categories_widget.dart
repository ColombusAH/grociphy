import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/dark_theme_provider.dart';
import 'package:flutter_first_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.catText, required this.imgPath, required this.color});
  final String catText, imgPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color themeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        print('Category tapped');
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.7), width: 2),
        ),
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath),fit: BoxFit.fill)),
                      
            ),
            TextWidget(text: catText, color: color, textSize: 20)
          ],
        ),
      ),
    );
  }
}
