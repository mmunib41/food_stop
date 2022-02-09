import 'package:flutter/material.dart';
import 'package:food_stop/pages/allsearch.dart';
import 'package:food_stop/pages/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class searchrecipie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: JsonListView(),
      ),
    );
  }
}

class JsonListView extends StatefulWidget {
  JsonListViewWidget createState() => JsonListViewWidget();
}

class JsonListViewWidget extends State {
  List categoryitemlist = [];

  var SelectValue;
  var SelectValue1;
  var SelectValue2;

  Future getalldata() async {
    var url = "https://amdtechx.com/flutter/allingredients.php";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      setState(() {
        categoryitemlist = jsondata;
      });
    }
  }

  @override
  // Showing Alert Dialog with Response JSON Message.

  // Getting value from Controller

  late final Future? myFuture = getalldata();

  Future search() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => allsearch(
                  ingredient: SelectValue,
                  ingredient1: SelectValue1,
                  ingredient2: SelectValue2,
                )));
  }

  @override
  Widget build(BuildContext context) {
    Future:
    myFuture;

    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Text(
            'Select all the values',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          DropdownButton(
              hint: Text(
                "Select Ingredient 1",
                style: TextStyle(fontSize: 20),
              ),
              value: SelectValue,
              items: categoryitemlist.map((ingredient) {
                return DropdownMenuItem(
                    value: ingredient['name'], child: Text(ingredient['name']));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  SelectValue = value;
                });
              }),
          DropdownButton(
              hint: Text(
                "Select Ingredient 2",
                style: TextStyle(fontSize: 20),
              ),
              value: SelectValue1,
              items: categoryitemlist.map((ingredient) {
                return DropdownMenuItem(
                    value: ingredient['name'], child: Text(ingredient['name']));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  SelectValue1 = value;
                });
              }),
          DropdownButton(
              hint: Text(
                "Select Ingredient 3",
                style: TextStyle(fontSize: 20),
              ),
              value: SelectValue2,
              items: categoryitemlist.map((ingredient) {
                return DropdownMenuItem(
                    value: ingredient['name'], child: Text(ingredient['name']));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  SelectValue2 = value;
                });
              }),
          RaisedButton(
            onPressed: search,
            color: Colors.teal,
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text('Search Recipie'),
          ),
        ],
      ),
    ));
  }
}
