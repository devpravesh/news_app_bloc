import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app_bloc/Database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'API/api_model.dart';
import 'bloc/covid_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CovidBloc _newsBloc = CovidBloc();
  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    // var db = openDatabase('news.db');
    // print(db.then((value) => print(value)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ThemeData(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // backgroundColor: Get.isDarkMode ? Colors.black12:Colors.white,
        // title: Text(""),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "CNBC",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                // StoreNews().database;
                StoreNews().insertNews(NewsModel());
              },
              child: Icon(
                Icons.menu,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              " Hey, Jon!",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Discover Latest News",
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: Get.width / 9,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for news",
                    ),
                  ),
                ),
                Container(
                    height: 40,
                    width: 40,
                    color: Colors.red,
                    child: const Icon(Icons.search))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                category(Icons.people_alt, Colors.amber, () {}),
                category(Icons.newspaper, Colors.amber, () {}),
                category(Icons.run_circle, Colors.amber, () {}),
                category(Icons.movie, Colors.amber, () {}),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 25,
                  color: Colors.red,
                  width: 3,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Breaking News",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            Flexible(child: _buildListCovid()),
          ],
        ),
      ),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return _buildLoading();
              } else if (state is CovidLoading) {
                return _buildLoading();
              } else if (state is CovidLoaded) {
                return _buildCard(context, state.newsModel);
              } else if (state is CovidError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, NewsModel model) {
    return ListView.builder(
      itemCount: model.articles!.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: "${model.articles![index].urlToImage}",
            errorWidget: (context, url, error) {
              return Image.asset('assets/images/news.jpg');
            },
            height: 150,
            width: 150,
          ),
          title: Text(
            "${model.articles![index].title}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 3,
            // softWrap: true,
          ),
          subtitle: Text(timeago.format(
              DateTime.parse(model.articles![index].publishedAt.toString()))),
        ));
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

Widget category(IconData name, color, VoidCallback onclick) {
  return Flexible(
    child: Container(
      // color: color,
      height: 100,
      width: 100,
      decoration: const BoxDecoration(),
      child: IconButton(
        icon: Icon(name),
        onPressed: onclick,
      ),
    ),
  );
}
