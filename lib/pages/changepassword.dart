import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class changepassword extends StatelessWidget {
  final String email;
  changepassword({key, required this.email}) : super(key: key);

  TextEditingController passwordFieldController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.

    // Getting value from Controller
    var pass = passwordFieldController.text.toString();

    // SERVER API URL
    String url = 'https://amdtechx.com/flutter/changepassword.php';

    // Store all data with Param Name.
    var data = {'pass': pass.toString(), 'email': email.toString()};

    // Starting Web API Call.
    var response =
        await http.post(Uri.parse(url), body: json.encode(data).toString());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    if (message == 'Record updated successfully') {
      Fluttertoast.showToast(
          msg: "Record updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Not updated Enter",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    // If Web call Success than Hide the CircularProgressIndicator.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: Text('User Profile'),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: <Widget>[
        Divider(),
        Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: Text('Welcome ' + email.toString() + ' to Profile Screen')),
        Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: passwordFieldController,
              autocorrect: true,
              decoration:
                  InputDecoration(hintText: 'Enter your New Password Here'),
            )),
        RaisedButton(
          onPressed: userRegistration,
          color: Colors.teal,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text('Click Here To CHANGE Password'),
        ),
      ]))),
    ));
  }
}
