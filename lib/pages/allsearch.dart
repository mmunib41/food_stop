import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class allsearch extends StatelessWidget {
  final String ingredient;
  final String ingredient1;
  final String ingredient2;

// Receiving Email using Constructor.
  const allsearch(
      {Key? key,
      required this.ingredient,
      required this.ingredient1,
      required this.ingredient2,
      ing,
      ing1,
      ing2})
      : super(key: key);
  Future<List<recipiedata>> fetchusers() async {
    var data = {
      'ingredient1': ingredient,
      'ingredient2': ingredient1,
      'ingredient3': ingredient2
    };

    var response = await http.post(
        Uri.parse('https://amdtechx.com/flutter/searchrecipie.php'),
        body: json.encode(data).toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<recipiedata> userList = items.map<recipiedata>((json) {
        return recipiedata.fromJson(json);
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
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: FutureBuilder<List<recipiedata>>(
        future: fetchusers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!
                .map((data) => Column(
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text('Name = ' + data.name.toString()),
                            subtitle: Text(
                                'Description = ' + data.description.toString()),
                          ),
                        )
                      ],
                    ))
                .toList(),
          );
        },
      ),
    ));
  }
}

class recipiedata {
  int id;
  String name;
  String description;
  String imageurl;
  String imageurls;
  String totaltime;
  int totalcalories;

  recipiedata(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageurl,
      required this.imageurls,
      required this.totalcalories,
      required this.totaltime});

  factory recipiedata.fromJson(Map<String, dynamic> json) {
    return recipiedata(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageurl: json['imageurl'],
      imageurls: json['imageurls'],
      totalcalories: json['totalcalories' as String],
      totaltime: json['totaltime' as String],
    );
  }
}
