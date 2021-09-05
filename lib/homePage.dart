import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'audioModel.dart';
import 'database/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = new DatabaseHelper();
  List<AudioModel> audios = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() async {
    audios = await db.getAllProductPaths();
    print(audios[0].toString());
  }

  addNewRecord(String name, String path) async {
    await db.addProductToAudio(name, path);
    audios = await db.getAllProductPaths();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Sqlite"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => addNewRecord("Name","path"),
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          Visibility(
            visible: audios.length == 0,
            child: Container(),
            replacement: Expanded(
              child: ListView.builder(
                  itemCount: audios.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Text(
                              audios[0].audioName!,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            ),
        ],
      ),
    );
  }
}
