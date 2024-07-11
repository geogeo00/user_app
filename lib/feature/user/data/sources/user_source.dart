import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_app/feature/user/data/model/user_model.dart';


abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers(int page);
  Future<UserModel> fetchUserDetail(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://reqres.in/';

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> fetchUsers(int page) async {
    final response = await client.get(Uri.parse('${baseUrl}api/users?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List).map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> fetchUserDetail(int id) async {
    final response = await client.get(Uri.parse('${baseUrl}api/users/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }
}

class ServerException implements Exception {}
