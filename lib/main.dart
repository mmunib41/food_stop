import 'package:flutter/material.dart';
import 'package:food_stop/pages/add_recipie.dart';
import 'package:food_stop/pages/addcalories.dart';
import 'package:food_stop/pages/allingredient.dart';
import 'package:food_stop/pages/homepage.dart';

import 'package:food_stop/pages/login.dart';
import 'package:food_stop/pages/searchrecipie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Food Stop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: login());
  }
}
