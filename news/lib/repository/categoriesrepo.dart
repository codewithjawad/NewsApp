import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/model/categoriesmodel.dart';
class CategoriesRepo{
  // ignore: non_constant_identifier_names
  Future<CategoriesModel>FetchCategory(String category) async{
    var url='https://newsapi.org/v2/everything?q=$category&apiKey=f3361b080e00465fa3fb8c29bb53ea5f';
    final response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      return CategoriesModel.fromJson(body);
    }
    throw Exception('No Data!');
  }

}