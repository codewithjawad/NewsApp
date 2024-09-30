import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/model/newsheadlinesmodel.dart';

class NewsRepo {
  // ignore: non_constant_identifier_names
  Future<newsheadlinesmodel> FetchNews(String source) async {
    var url =
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=f3361b080e00465fa3fb8c29bb53ea5f';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return newsheadlinesmodel.fromJson(body);
    }
    throw Exception('No Data!');
  }
}
