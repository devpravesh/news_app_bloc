import 'package:news_app_bloc/API/api_model.dart';
import 'package:sqflite/sqflite.dart';

const String tableNews = 'newstable1';
const String columnId = 'id';
const String columnsrc = 'source';
const String columnauth = 'author';
const String columnTitle = 'title';
const String columnDescription = 'description';
const String columnurl = 'url';
const String columnurltoimg = 'urlToImage';
const String columnPublishedAt = 'publishedAt';
const String columnContent = 'content';
//  Source? source;
// String? author;
// String? title;
// String? description;
// String? url;
// String? urlToImage;
// DateTime?publishedAt;
// String? content;
////////////////////////////
// const String columnId = 'id';
// const String columnTitle = 'status';
// const String columnPublishedAt = 'totalResults';
// const String columnDescription = 'articles';

// const String columnContent = 'content';
class StoreNews {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "new.db";
    print("db path:$path");
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        // db.execute('''
        //   create table $tableNews (
        //   $columnId integer primary key autoincrement,
        //   $columnTitle text not null,
        //   $columnDescription text not null,
        //   $columnPublishedAt text not null)
        // ''');
        db.execute('''
          create table $tableNews (
          $columnId integer primary key autoincrement,
          $columnsrc text not null,
          $columnauth text not null,
          $columnTitle text not null,
          $columnDescription text not null,
          $columnurl text not null,
          $columnurltoimg text not null,
          $columnPublishedAt text not null)
          $columnContent text not null,
        ''');
      },
    );
    return database;
  }

  void insertNews(NewsModel newsModel) async {
    var db = await database;
    var result = await db.insert(tableNews, Article().toJson());
    print('result : $result');
  }
}
