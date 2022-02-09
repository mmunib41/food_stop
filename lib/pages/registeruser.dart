import 'package:flutter/material.dart';
import 'package:food_stop/pages/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class registeruser extends StatefulWidget {
  registeruserState createState() => registeruserState();
}

class registeruserState extends State {
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    // Getting value from Controller
    var name = nameController.text.toString();
    var email = emailController.text.toString();
    var pass = passwordController.text.toString();
    if (name == "" || email == "" || pass == "") {
      setState(() {
        visible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Please enter all values"),
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
    } else {
      // SERVER API URL
      String url = 'https://amdtechx.com/flutter/signup.php';

      // Store all data with Param Name.
      var data = {'name': name, 'pass': pass, 'email': email};
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };
      // Starting Web API Call.
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add User"),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('User Registration Form',
                      style: TextStyle(fontSize: 21))),
              Divider(),
              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: nameController,
                    autocorrect: true,
                    decoration:
                        InputDecoration(hintText: 'Enter Your Name Here'),
                  )),
              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: emailController,
                    autocorrect: true,
                    decoration:
                        InputDecoration(hintText: 'Enter Your Email Here'),
                  )),
              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: passwordController,
                    autocorrect: true,
                    obscureText: true,
                    decoration:
                        InputDecoration(hintText: 'Enter Your Password Here'),
                  )),
              RaisedButton(
                onPressed: userRegistration,
                color: Colors.teal,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text('Click Here To Register User Online'),
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
