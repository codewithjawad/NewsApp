import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/model/categoriesmodel.dart';
class CategoriesRepo{
  // ignore: non_constant_identifier_names
  Future<CategoriesModel>FetchCategory(String category) async{
    var url='https://newsapi.org/v2/everything?q=$category&apiKey=ur api key';
    final response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      return CategoriesModel.fromJson(body);
    }
    throw Exception('No Data!');
  }

}