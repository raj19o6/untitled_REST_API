import 'package:flutter/material.dart';
import 'package:untitled/screens/model/user.dart';
import 'package:untitled/screens/services/user_api.dart';
import 'package:untitled/screens/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return GestureDetector(
            onTap: () {
              // Navigate to the user profile screen and pass the selected user's data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(
                    user: user,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(user.fullName),
                subtitle: Text(user.phone),
                trailing: Text(user.location.state),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(user.picture.thumbnail),
                ),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rest API"),
      ),
    );
  }

  void fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
