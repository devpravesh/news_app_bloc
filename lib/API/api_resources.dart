import 'package:dio/dio.dart';

import 'api_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://newsapi.org/v2/everything?q=tesla&from=2022-09-01&sortBy=publishedAt&apiKey=c10c5b98adef41208852e54ad2cb4bb5';

  Future<NewsModel> fetchCovidList() async {
    try {
      Response response = await _dio.get(_url);
      return NewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return NewsModel.withError("Data not found / Connection issue");
    }
  }
}
