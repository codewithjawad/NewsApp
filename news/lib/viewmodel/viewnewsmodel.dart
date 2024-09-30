import 'package:news/model/categoriesmodel.dart';
import 'package:news/model/newsheadlinesmodel.dart';
import 'package:news/repository/categoriesrepo.dart';
import 'package:news/repository/newsrepo.dart';

class NewsViewModel {
  final NewsRepo _api = NewsRepo();
  Future<newsheadlinesmodel> fetchnewsheadlines(String source) async {
    final response = await _api.FetchNews(source);
    return response;
  }

  // ignore: non_constant_identifier_names
  final _api_new = CategoriesRepo();
  Future<CategoriesModel> fetchCategory(String category) async {
    final response = await _api_new.FetchCategory(category);
    return response;
  }
}
