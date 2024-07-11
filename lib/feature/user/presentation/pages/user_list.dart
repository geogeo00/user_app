import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/feature/user/data/repositories/user_repository_implement.dart';
import 'package:user_app/feature/user/domain/usecases/fetch_users.dart';

import '../bloc/user_bloc.dart';
import '../widgets/user_list_item.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late UserBloc _userBloc;
  ScrollController scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  @override
  void initState() {
    super.initState();
    _userBloc =
        UserBloc(fetchUsers: FetchUsers(UserRepositoryImpl(http.Client())));
    _userBloc.add(
        FetchUserListEvent(page: _currentPage)); // Adjust page number as needed
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _userBloc.close();
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _isLoading = true;
      _currentPage++;
      _userBloc.add(FetchUserListEvent(page: _currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Users')),
      body: BlocProvider(
        create: (context) => _userBloc,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return UserListItem(user: state.users[index]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textButton(1),
                      const SizedBox(
                        width: 20,
                      ),
                      textButton(2),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget textButton(int index) {
    return TextButton(
        onPressed: () {
          _currentPage = _currentPage == 2 ? 1 : 2;
          _userBloc.add(FetchUserListEvent(page: _currentPage));
        },
        child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: index != _currentPage
                    ? Colors.transparent
                    : Colors.blueAccent,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Text(
              index.toString(),
              style: TextStyle(
                  color: index != _currentPage ? Colors.black : Colors.white),
            ))));
  }
}
