import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/model/newsheadlinesmodel.dart';

class NewsRepo {
  // ignore: non_constant_identifier_names
  Future<newsheadlinesmodel> FetchNews(String source) async {
    var url =
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=ur api key';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return newsheadlinesmodel.fromJson(body);
    }
    throw Exception('No Data!');
  }
}
