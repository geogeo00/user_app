import 'package:flutter/material.dart';
import 'package:user_app/feature/user/presentation/pages/user_details.dart';
import '../../domain/entities/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adjust elevation as needed
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserDetailPage(user: user),
          ));
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
