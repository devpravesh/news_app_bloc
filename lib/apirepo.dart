import 'api_model.dart';
import 'api_resources.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<NewsModel> fetchCovidList() {
    return _provider.fetchCovidList();
  }
}

class NetworkError extends Error {}
