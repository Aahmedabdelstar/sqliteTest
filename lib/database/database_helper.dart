import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_test/audioModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "megggR.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE AudioModel(id INTEGER PRIMARY KEY, productPath TEXT , category TEXT)");

    await db.execute(
        "CREATE TABLE audio(id INTEGER PRIMARY KEY, audioName TEXT, audioPath TEXT )");


    // await db.execute(
    //     "CREATE TABLE orderss(id INTEGER PRIMARY KEY, orderId TEXT , regionID TEXT , totalSalary TEXT , orderDate TEXT)");
  }


  Future<int> deleteProductFromAudio(String productId) async {
    var dbClient = await db;
    int res = await dbClient!
        .rawDelete('DELETE FROM audio WHERE productPath = ?', [productId]);
    return res;
  }


  Future<int> addProductToAudio(String audioName, String audioPath) async {
    var dbClient = await db;
    var map = new Map<String, dynamic>();
    map["audioName"] = audioName;
    map["audioPath"] = audioPath;
    int res = await dbClient!.insert("audio", map);
    return res;
  }



  Future<List<AudioModel>> getAllProductPaths() async {
    var dbClient = await db;
    List<AudioModel> productPaths = [];
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM audio');
    for (int i = 0; i < list.length; i++) {
      var audioModel = new AudioModel(list[i]["audioName"], list[i]["audioPath"] );
      productPaths.add(audioModel);
    }
    return productPaths;
  }

 }
