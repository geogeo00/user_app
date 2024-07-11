import 'package:equatable/equatable.dart';
import 'package:user_app/core/usecases/usecase.dart';
import 'package:user_app/feature/user/domain/entities/user.dart';
import 'package:user_app/feature/user/domain/repositories/user_repository.dart';

class FetchUserDetail implements UseCase<User, Params> {
  final UserRepository repository;

  FetchUserDetail(this.repository);

  @override
  Future< User> call(Params params) async {
    return await repository.fetchUserDetail(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({required this.id});

  @override
  List<Object> get props => [id];
}