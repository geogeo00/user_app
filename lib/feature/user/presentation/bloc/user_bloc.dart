import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/fetch_users.dart';
import 'package:dartz/dartz.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUsers fetchUsers;

  UserBloc({required this.fetchUsers}) : super(UserInitial()) {
    on<FetchUserListEvent>(_onFetchUserListEvent);
  }

  _onFetchUserListEvent(
      FetchUserListEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUsers = await fetchUsers(Params(page: event.page));
    emit(UserLoaded(users: failureOrUsers));
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else {
      return 'Unexpected Error';
    }
  }
}
