import 'package:equatable/equatable.dart';
import 'package:user_app/core/usecases/usecase.dart';
import 'package:user_app/feature/user/domain/entities/user.dart';
import 'package:user_app/feature/user/domain/repositories/user_repository.dart';

class FetchUsers implements UseCase<List<User>, Params> {
  final UserRepository repository;

  FetchUsers(this.repository);

  @override
  Future<List<User>> call(Params params) async {
    return await repository.fetchUsers(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({required this.page});

  @override
  List<Object> get props => [page];
}
