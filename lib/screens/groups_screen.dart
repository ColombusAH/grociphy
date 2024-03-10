import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/group.dart';
import 'package:flutter_first_app/providers/groups_provider.dart';
import 'package:flutter_first_app/screens/group_details_screen.dart';
import 'package:provider/provider.dart';
// Adjust the import path accordingly

class GroupsListScreen extends StatefulWidget {
  @override
  State<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<GroupsListScreen> {
  @override
  void initState() {
    super.initState();
    final groupsProvider = Provider.of<GroupsProvider>(context, listen: false);
    groupsProvider.fetchGroups(); // Asynchronously load groups
  }

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Game-Themed Groups"),
      ),
      body: ListView.builder(
        itemCount: groupsProvider.groups.length,
        itemBuilder: (context, index) {
          final groupData = groupsProvider.groups[index];
          Group.fromJson(groupData); // Assuming Group.fromJson is implemented
          // final group = groupsProvider.groups[index];
          final group = Group.fromJson(groupData);
          return GroupListItem(group: group);
        },
      ),
    );
  }
}

class GroupListItem extends StatelessWidget {
  final Group group;

  GroupListItem({required this.group});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed('/group-details', arguments: group);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailsScreen(group: group),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(group.description),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: group.members.map<Widget>((member) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundImage: member.avatar != ''
                            ? NetworkImage(member.avatar)
                            : AssetImage('assets/images/indica.png')
                                as ImageProvider,
                      ),
                    );
                  }).toList(), // This line might need adjustment based on your actual data structure
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
