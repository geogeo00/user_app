import 'package:user_app/feature/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String avatar,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          avatar: avatar,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}