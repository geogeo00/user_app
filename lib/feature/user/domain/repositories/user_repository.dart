import 'package:user_app/feature/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> fetchUsers(int page);
  Future<User> fetchUserDetail(int id);
}
