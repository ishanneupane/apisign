import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/comm.dart';

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<User> users = [];

  Future<void> fetchUsers() async {
    const url = 'https://testing.esnep.com/eliterestro/api/acc/pub/slider';

    final response = await http.get(Uri.parse(url),
        headers: headers); //header le chaine linxa//header le chaine linxa
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        users = (jsonData['Values'] as List<dynamic>)
            .map((userJson) => User.fromJson(userJson))
            .toList();
      });
    } else {
      print('Failed to fetch users. Status code: ${response.statusCode}');
    }
  }

  var headers = {
    'Content-Type': 'application/json',
    'Signature': 'p0m76',
  }; //jj chainxa yei halne or or 'Signature': APIconst.getsignature();

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "APIs",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            // leading: Image.network(user.image),
            leading: Image.network(
              user.image,
              errorBuilder: (context, exception, stackTrace) {
                return Text('😢');
              },
            ),
            // leading: Text(user.image),
            title: Text(
              user.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
            subtitle: Text(user.redUrl),
            subtitleTextStyle: TextStyle(color: Colors.green),
          );
        },
      ),
    );
  }
}
