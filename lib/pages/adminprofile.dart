import 'package:flutter/material.dart';
import 'package:food_stop/pages/add_recipie.dart';
import 'package:food_stop/pages/all_users.dart';
import 'package:food_stop/pages/allingredient.dart';

int selectedIndex = 0;
List<Widget> listWidgets = [allingredient(), addrecipie(), alluser()];
List<IconData> listIcons = [
  Icons.rss_feed,
  Icons.supervised_user_circle,
  Icons.message,
  Icons.more
];
List<String> listTitles = ['Ingredient', 'Recipie', 'All Users'];

class adminprofilescreen extends StatelessWidget {
// Creating String Var to Hold sent Email.

  final String email;

// Receiving Email using Constructor.
  const adminprofilescreen({Key? key, required this.email}) : super(key: key);

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
                Tab(icon: Icon(Icons.menu_book), text: "RECIPIE"),
                Tab(icon: Icon(Icons.food_bank), text: "INGREDIENTS"),
                Tab(icon: Icon(Icons.verified_user), text: "USERS"),
              ],
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
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
              addrecipie(),
              allingredient(),
              alluser(),
            ],
          ),
        ),
      ),
    );
  }
}
