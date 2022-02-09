import 'package:flutter/material.dart';
import 'package:food_stop/pages/add_recipie.dart';
import 'package:food_stop/pages/addcalories.dart';
import 'package:food_stop/pages/all_users.dart';
import 'package:food_stop/pages/allingredient.dart';
import 'package:food_stop/pages/changepassword.dart';
import 'package:food_stop/pages/homepage.dart';
import 'package:food_stop/pages/recipe.dart';
import 'package:food_stop/pages/searchrecipie.dart';

class profilescreen extends StatelessWidget {
// Creating String Var to Hold sent Email.

  final String email;

// Receiving Email using Constructor.
  const profilescreen({Key? key, required this.email}) : super(key: key);

// User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Welcome ' + email),
            leading: Icon(Icons.accessibility),
            backgroundColor: Colors.teal,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.restaurant_menu), text: "RECIPIE"),
                Tab(
                    icon: Icon(Icons.settings_input_component_sharp),
                    text: "Calories"),
                Tab(icon: Icon(Icons.search), text: "Ingrdient Search"),
              ],
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => changepassword(
                                  email: email,
                                )),
                      );
                    },
                    child: Icon(
                      Icons.supervised_user_circle,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.logout),
                  )),
            ],
          ),
          body: TabBarView(
            children: [
              HomePage(email: email),
              addcalories(email: email),
              searchrecipie()
            ],
          ),
        ),
      ),
    );
  }
}
