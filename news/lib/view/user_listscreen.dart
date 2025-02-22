import 'package:flutter/material.dart';
import 'package:news/model/usersmodel.dart';
import 'package:news/repository/user_repo.dart';
import 'package:news/services/api_service.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final UserRepository userRepository = UserRepository(
    apiService: ApiService(
        baseUrl: 'https://crudcrud.com/api/85e70356b4ec4bbfac3554e1c5c71de3'),
  );

  List<Usersmodel> users = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() => isLoading = true);
    try {
      final fetchedUsers = await userRepository.fetchUsers();
      setState(() {
        users = fetchedUsers;
        errorMessage = null;
      });
    } catch (e) {
      setState(() => errorMessage = e.toString());
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users[index].name ?? ""),
                      subtitle: Text(users[index].colour ?? ""),
                    );
                  },
                ),
    );
  }
}
