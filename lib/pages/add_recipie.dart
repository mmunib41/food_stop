import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class addrecipie extends StatefulWidget {
  const addrecipie({Key? key}) : super(key: key);

  @override
  addrecipieState createState() => addrecipieState();
}

class addrecipieState extends State<addrecipie> {
  List categoryitemlist = [];

  var SelectValue;
  Future getalldata() async {
    var url = "https://amdtechx.com/flutter/allingredients.php";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      setState(() {
        categoryitemlist = jsondata;
      });
    }

    print(categoryitemlist);
  }

  List categoryitemlist2 = [];

  var SelectValue2;
  Future getalldata2() async {
    var url = "https://amdtechx.com/flutter/recipiename.php";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      setState(() {
        categoryitemlist2 = jsondata;
      });
    }

    print(categoryitemlist2);
  }

  bool visible = false;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageurlController = TextEditingController();
  final imageurlsController = TextEditingController();
  final totaltimeController = TextEditingController();
  final totalcaloriesController = TextEditingController();

  Future addingrecipies() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    var name = nameController.text.toString();
    var description = descriptionController.text.toString();
    var imageurl = imageurlController.text.toString();
    var imageurls = imageurlsController.text.toString();
    var totaltime = totaltimeController.text.toString();
    var totalcalories = totalcaloriesController.text.toString();

    // SERVER API URL
    String url = 'https://amdtechx.com/flutter/recipie.php';

    // Store all data with Param Name.
    var data = {
      'name': name,
      'description': description,
      'imageurl': imageurl,
      'imageurls': imageurls,
      'totaltime': totaltime,
      'totalcalories': totalcalories
    };

    var response =
        await http.post(Uri.parse(url), body: json.encode(data).toString());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
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

  Future addingrec() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    var name = SelectValue2.toString();
    var ingredient = SelectValue.toString();

    // SERVER API URL
    String url = 'https://amdtechx.com/flutter/addrecipieing.php';

    // Store all data with Param Name.
    var data = {
      'name': name,
      'ingredient': ingredient,
    };

    var response =
        await http.post(Uri.parse(url), body: json.encode(data).toString());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
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

  late final Future? myFuture = getalldata();
  late final Future? myFuture2 = getalldata2();
  @override
  Widget build(BuildContext context) {
    Future:
    myFuture;
    myFuture2;

    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Column(
        children: <Widget>[
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: nameController,
                autocorrect: true,
                decoration:
                    InputDecoration(hintText: 'Enter Recipie Name Here'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: descriptionController,
                autocorrect: true,
                decoration:
                    InputDecoration(hintText: 'Enter Recipie Description Here'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: imageurlController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Short Image Url'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: imageurlsController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Long Image Url'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: totaltimeController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Total Time'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: totalcaloriesController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Total Calories'),
              )),
          RaisedButton(
            onPressed: addingrecipies,
            color: Colors.teal,
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text('Click HERE TO ADD RECIPIE'),
          ),
          DropdownButton(
              hint: Text("Select Ingredient"),
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
              hint: Text("Select Recipie Name"),
              value: SelectValue2,
              items: categoryitemlist2.map((recipie) {
                return DropdownMenuItem(
                    value: recipie['name'], child: Text(recipie['name']));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  SelectValue2 = value;
                });
              }),
          RaisedButton(
            onPressed: addingrec,
            color: Colors.teal,
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text('ADD Ingridient'),
          ),
          Visibility(
              visible: visible,
              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator())),
        ],
      ),
    )));
  }
}
