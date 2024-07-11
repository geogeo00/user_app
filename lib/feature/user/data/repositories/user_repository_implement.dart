import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_app/feature/user/data/model/user_model.dart';
import 'package:user_app/feature/user/domain/entities/user.dart';
import 'package:user_app/feature/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final http.Client client;
  final String baseUrl = 'https://reqres.in/';

  UserRepositoryImpl(this.client);

  @override
  Future<List<User>> fetchUsers(int page) async {
    final response =
        await client.get(Uri.parse('${baseUrl}api/users?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<UserModel> users = (data['data'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      return users;
    } else {
      return [];
    }
  }

  @override
  Future<User> fetchUserDetail(int id) async {
    final response = await client.get(Uri.parse('${baseUrl}api/users/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      return UserModel.fromJson({});
    }
  }
}
