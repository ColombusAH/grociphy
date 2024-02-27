import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/auth_provider.dart';
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
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final TextEditingController addressTextController =
        TextEditingController(text: "");
    @override
    void dispose() {
      addressTextController.dispose();
      super.dispose();
    }

    Future<void> showAddressDialog() async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('sss'),
              content: TextField(
                controller: addressTextController,
                maxLines: 5,
                decoration: const InputDecoration(hintText: 'ssdsdsd'),
                onChanged: (value) => print(value),
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const TextWidget(
                      text: 'Update', color: Colors.cyan, textSize: 18),
                )
              ],
            );
          });
    }

    Future<void> showLogoutDialog() async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(IconlyBold.logout, color: Colors.cyan, size: 30),
                  const TextWidget(
                      text: 'Logout', color: Colors.cyan, textSize: 18),
                ],
              ),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    authProvider.logout();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const TextWidget(
                      text: 'Yes', color: Colors.cyan, textSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const TextWidget(
                      text: 'No', color: Colors.cyan, textSize: 18),
                )
              ],
            );
          });
    }

    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                text: 'Hi,  ',
                style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: userProvider.user?.email,
                      style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('ssdsd');
                        })
                ],
              )),
              TextWidget(text: 'Email@email.com', color: color, textSize: 18),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              _buildListTile(
                  title: 'Profile',
                  icon: IconlyBold.profile,
                  subtitle: 'This is the user screen',
                  trailingIcon: IconlyLight.arrowRight2,
                  color: color,
                  onTap: () {}),
              _buildListTile(
                  title: 'Address 2',
                  icon: IconlyBold.bag,
                  subtitle: 'This is the user screen',
                  trailingIcon: IconlyLight.arrowRight2,
                  color: color,
                  onTap: showAddressDialog),
              _buildListTile(
                  title: 'Forgot Password',
                  icon: IconlyBold.unlock,
                  trailingIcon: IconlyLight.arrowRight2,
                  color: color,
                  onTap: () {}),
              SwitchListTile(
                title: TextWidget(
                  text: themeState.getDarkTheme ? 'Light Theme' : 'Dark Theme',
                  color: color,
                  textSize: 18,
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
                  color: color,
                  onTap: showLogoutDialog)
            ],
          ),
        ),
      ));
    });
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
      leading: Padding(
        padding:
            EdgeInsets.only(bottom: 22.0), // Adjust the top padding as needed
        child: Icon(icon),
      ),
      trailing: Icon(trailingIcon),
      onTap: onTap,
    );
  }
}
