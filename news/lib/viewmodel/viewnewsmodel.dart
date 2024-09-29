import 'package:news/model/newsheadlinesmodel.dart';
import 'package:news/repository/newsrepo.dart';

class Viewnewsmodel {
  Newsrepo repo = Newsrepo();
  Future<newsheadlinesmodel> fetchnewsheadlines() async {
    final response = repo.fetchnewsheadlines();
    return response;
  }
}
