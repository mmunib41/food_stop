import 'dart:convert';
import 'dart:async';
import "package:flutter/material.dart";
import 'package:food_stop/pages/all_users.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chewie/chewie.dart';
import 'package:food_stop/pages/video_items.dart';
import 'package:video_player/video_player.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final String email;
  HomePage({key, required this.email}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: JsonListView(email),
      ),
    );
  }
}

class JsonListView extends StatefulWidget {
  JsonListView(String email);
  JsonListViewWidget createState() => JsonListViewWidget();
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

class JsonListViewWidget extends State {
  Future<List<recipiedata>> fetchStudents() async {
    var response = await http
        .get(Uri.parse('https://amdtechx.com/flutter/allrecipies.php'));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<recipiedata> recipieList = items.map<recipiedata>((json) {
        return recipiedata.fromJson(json);
      }).toList();

      return recipieList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  navigateToNextActivity(
      BuildContext context, String dataHolder, String dataholder2) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SecondScreenState(dataHolder.toString(), dataholder2.toString())));
  }

  List<recipiedata> Recipies = List.empty();
  List<recipiedata> FilteredRecipies = List.empty();

  @override
  void initState() {
    super.initState();
    fetchStudents().then((recipiedatafromserver) {
      setState(() {
        Recipies = recipiedatafromserver;
        FilteredRecipies = Recipies;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: <Widget>[
      TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Enter Name or text',
        ),
        onChanged: (string) {
          setState(() {
            FilteredRecipies = Recipies.where((u) => (u.name
                        .toLowerCase()
                        .contains(string.toLowerCase()) ||
                    u.description.toLowerCase().contains(string.toLowerCase())))
                .toList();
          });
        },
      ),
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: FilteredRecipies.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              leading: Image.network(FilteredRecipies[index].imageurl),
              title: Text(FilteredRecipies[index].name),
              subtitle: Text(FilteredRecipies[index].description),
              onTap: () {
                navigateToNextActivity(context, FilteredRecipies[index].name,
                    FilteredRecipies[index].imageurls);
              },
            ));
          },
        ),
      ),
    ])));
  }
}

//
class SecondScreenState extends StatefulWidget {
  final String idHolder;
  final String dataholder2;
  SecondScreenState(this.idHolder, this.dataholder2);
  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.idHolder, this.dataholder2);
  }
}

class SecondScreen extends State<SecondScreenState> {
  final String idHolder;
  final String dataholder2;
  SecondScreen(this.idHolder, this.dataholder2);

  Future<List<recipiedata>> fetchingrdients() async {
    var data = {'name': idHolder.toString()};

    var response = await http.post(
        Uri.parse('https://amdtechx.com/flutter/geting.php'),
        body: json.encode(data).toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<recipiedata> studentList = items.map<recipiedata>((json) {
        return recipiedata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  Future<List<recipiedata>> fetchStudent() async {
    var data = {'name': idHolder.toString()};

    var response = await http.post(
        Uri.parse('https://amdtechx.com/flutter/getrecipies.php'),
        body: json.encode(data).toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<recipiedata> studentList = items.map<recipiedata>((json) {
        return recipiedata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.network(dataholder2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Showing Selected Recipie Details'),
                automaticallyImplyLeading: true,
                backgroundColor: Colors.teal,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: FutureBuilder<List<recipiedata>>(
              future: fetchStudent(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                return ListView(
                  children: snapshot.data!
                      .map((data) => Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print(data.name);
                                },
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 500.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  data.imageurl,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Card(
                                          child: ListTile(
                                        title:
                                            Text("Recipie Name: " + data.name),
                                        subtitle: Text("Description:" +
                                            data.description.toString()),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text("Total Time: " +
                                            data.totaltime +
                                            "  Total Calories:" +
                                            data.totalcalories.toString()),
                                      )),
                                      VideoItems(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                                data.imageurls),
                                        looping: true,
                                        autoplay: true,
                                      ),
                                    ]),
                              )
                            ],
                          ))
                      .toList(),
                );
              },
            )));
  }
}
