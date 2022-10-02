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

class StoreNews {
  static Database? _database;

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + 'my.db';

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE News ("
        "$columnId integer primary key autoincrement,"
        " $columnsrc text not null,"
        "$columnauth text not null,"
        "$columnTitle text not null,"
        "$columnDescription text not null,"
        "$columnurl text not null,"
        "$columnurltoimg text not null,"
        "$columnPublishedAt text not null,"
        "$columnContent text not null"
        ")");
  }

  void insertNews(Article article) async {
    var db = await createDatabase();
    var result = await db.insert("News", article.toMap());
    print('result : $result');
  }

  getdata() async {
    var db = await createDatabase();
    Map<String, dynamic> maps = await db.query('News');
    return Article.fromJson(maps);
  }
}
