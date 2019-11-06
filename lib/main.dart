import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


void main() => runApp(Demo());
class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  var users;
  List userList;
  Future getUser() async{
    http.Response response = await http.get("https://jsonplaceholder.typicode.com/users");
    users = json.decode(response.body);
    setState(() {
      userList = users;
    });
    //debugPrint(response.body);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("User Information"),
          centerTitle: true,
        ),
        body: ListView.builder(
        itemCount: userList == null ? 0 : userList.length,
        itemBuilder: (context, i){
          final user = userList[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("${user['name']}"),
            ),
          );
        },
        ),
      ),
    );
  }
}