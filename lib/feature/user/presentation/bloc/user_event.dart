part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserListEvent extends UserEvent {
  final int page;

  const FetchUserListEvent({required this.page});

  @override
  List<Object> get props => [page];
}
