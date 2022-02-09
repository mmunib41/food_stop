import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';

class addcalories extends StatelessWidget {
  final String email;
  addcalories({key, required this.email}) : super(key: key);

  TextEditingController caloriesFieldController = TextEditingController();

  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Future addcal() async {
    // Showing CircularProgressIndicator.

    // Getting value from Controller
    var calories = caloriesFieldController.text.toString();
    var date = DateTime.now();

    // SERVER API URL
    String url = 'https://amdtechx.com/flutter/addcalories.php';

    // Store all data with Param Name.
    var data = {
      'date': date.toString(),
      'calories': calories,
      'email': email.toString()
    };

    // Starting Web API Call.
    var response =
        await http.post(Uri.parse(url), body: json.encode(data).toString());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    if (message == 'New record created successfully') {
      Fluttertoast.showToast(
          msg: "Calories added successfully",
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
            title: Text('Please Enter Todays Calories'),
            content: Column(
              children: <Widget>[
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
                  addcal();
                },
              )
            ],
          );
        });
  }

  Future<List<caloriesdata>> fetchcaloriess() async {
    var data = {'email': email.toString()};
    var response = await http.post(
        Uri.parse('https://amdtechx.com/flutter/calories.php'),
        body: json.encode(data).toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<caloriesdata> caloriesList = items.map<caloriesdata>((json) {
        return caloriesdata.fromJson(json);
      }).toList();

      return caloriesList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _displayDialog(context),
        label: const Text('Add calories'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<caloriesdata>>(
        future: fetchcaloriess(),
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
                            title: Text('Date = ' + data.date.toString()),
                            subtitle:
                                Text('Calories = ' + data.calories.toString()),
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

class caloriesdata {
  String date;
  int calories;

  caloriesdata({required this.date, required this.calories});

  factory caloriesdata.fromJson(Map<String, dynamic> json) {
    return caloriesdata(date: json['date'], calories: json['calories']);
  }
}
