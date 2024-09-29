import 'package:http/http.dart' as http;

class Newsrepo {
  Future<void> fetchnewsheadlines() async {
    var url =
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=f3361b080e00465fa3fb8c29bb53ea5f";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
    } else {
      throw new Exception("error in fetching data");
    }
  }
}
