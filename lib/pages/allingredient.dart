import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class allingredient extends StatelessWidget {
  TextEditingController caloriesFieldController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();
  Future userRegistration() async {
    // Showing CircularProgressIndicator.

    // Getting value from Controller
    var calories = caloriesFieldController.text.toString();
    var name = nameFieldController.text.toString();

    // SERVER API URL
    String url = 'https://amdtechx.com/flutter/ingredients.php';

    // Store all data with Param Name.
    var data = {'name': name, 'calories': calories};

    // Starting Web API Call.
    var response =
        await http.post(Uri.parse(url), body: json.encode(data).toString());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    if (message == 'New record created successfully') {
      Fluttertoast.showToast(
          msg: "New record created successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Wrong Enter",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    // If Web call Success than Hide the CircularProgressIndicator.
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please Enter New Ingredient'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: nameFieldController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: caloriesFieldController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Calories'),
                )
              ],
            ),
            actions: <Widget>[
              new RaisedButton(
                child: new Text('Submit'),
                onPressed: () {
                  //fun1
                  Navigator.of(context).pop(); //fun2
                  userRegistration();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _displayDialog(context),
          label: const Text('Add Ingredient'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.teal,
        ),
        body: JsonListView(),
      ),
    );
  }
}

class ingredientdata {
  String name;
  int calories;

  ingredientdata({required this.name, required this.calories});

  factory ingredientdata.fromJson(Map<String, dynamic> json) {
    return ingredientdata(name: json['name'], calories: json['calories']);
  }
}

class JsonListView extends StatefulWidget {
  JsonListViewWidget createState() => JsonListViewWidget();
}

class JsonListViewWidget extends State<JsonListView> {
  Future<List<ingredientdata>> fetchingredients() async {
    var response = await http
        .get(Uri.parse('https://amdtechx.com/flutter/allingredientss.php'));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<ingredientdata> ingredientList = items.map<ingredientdata>((json) {
        return ingredientdata.fromJson(json);
      }).toList();

      return ingredientList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    const title = 'All ingredients ';
    return FutureBuilder<List<ingredientdata>>(
      future: fetchingredients(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data!
              .map((data) => Column(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.food_bank),
                          title: Text('Name = ' + data.name.toString()),
                          subtitle:
                              Text('Calories = ' + data.calories.toString()),
                        ),
                      )
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}
