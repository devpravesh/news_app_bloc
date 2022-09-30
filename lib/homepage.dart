import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'api_model.dart';
import 'bloc/covid_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CovidBloc _newsBloc = CovidBloc();
  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text(""),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "CNBC",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.menu,
              color: Colors.black,
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
                  color: Colors.black,
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
                  width: 2,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Breaking News")
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
                return _buildCard(context, state.covidModel);
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

  Widget _buildCard(BuildContext context, CovidModel model) {
    return ListView.builder(
      itemCount: model.countries!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Country: ${model.countries![index].country}"),
                  Text(
                      "Total Confirmed: ${model.countries![index].totalConfirmed}"),
                  Text("Total Deaths: ${model.countries![index].totalDeaths}"),
                  Text(
                      "Total Recovered: ${model.countries![index].totalRecovered}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

Widget category(IconData name, color, VoidCallback onclick) {
  return Container(
    // color: color,
    height: 100,
    width: 100,
    decoration: BoxDecoration(),
    child: IconButton(
      icon: Icon(name),
      onPressed: onclick,
    ),
  );
}
