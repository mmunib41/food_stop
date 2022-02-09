import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class alluser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white38,
        body: JsonListView(),
      ),
    );
  }
}

class userdata {
  int id;
  String name;
  String email;
  int role;

  userdata(
      {required this.id,
      required this.name,
      required this.role,
      required this.email});

  factory userdata.fromJson(Map<String, dynamic> json) {
    return userdata(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        email: json['email']);
  }
}

class JsonListView extends StatefulWidget {
  JsonListViewWidget createState() => JsonListViewWidget();
}

class JsonListViewWidget extends State {
  Future<List<userdata>> fetchusers() async {
    var response =
        await http.get(Uri.parse('https://amdtechx.com/flutter/allusers.php'));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<userdata> userList = items.map<userdata>((json) {
        return userdata.fromJson(json);
      }).toList();

      return userList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  selectedItem(BuildContext context, String dataHolder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(dataHolder),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'All Users ';
    return FutureBuilder<List<userdata>>(
      future: fetchusers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data!
              .map((data) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.ad_units_rounded),
                        title: Text('ID = ' + data.id.toString()),
                      ),
                      ListTile(
                        leading: Icon(Icons.verified_user),
                        title: Text('Name = ' + data.name.toString()),
                      ),
                      ListTile(
                        leading: Icon(Icons.messenger),
                        title: Text('Email = ' + data.email.toString()),
                      ),
                      ListTile(
                        leading: Icon(Icons.verified_user_rounded),
                        title: Text('Role = ' + data.role.toString()),
                      ),
                      Divider(color: Colors.teal),
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}
