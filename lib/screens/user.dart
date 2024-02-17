import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('This is the user screen'),
            leading: Icon(IconlyLight.profile),
            trailing: Icon(IconlyLight.arrowRight2),
          ),
        ],
      ),
    ));
  }
}
