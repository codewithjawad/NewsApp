import 'package:news/model/usersmodel.dart';
import 'package:news/services/api_service.dart';


class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<List<Usersmodel>> fetchUsers() async {
    try {
      final response = await apiService.get('/unicorns');
      return (response as List).map((json) => Usersmodel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
