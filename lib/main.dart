import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/feature/user/presentation/bloc/user_bloc.dart';
import 'package:user_app/feature/user/presentation/pages/user_list.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<UserBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Clean Architecture',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserListPage(),
      ),
    );
  }
}
