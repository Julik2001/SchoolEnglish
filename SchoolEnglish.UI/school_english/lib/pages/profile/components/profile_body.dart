import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/models/user/user.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/profile/components/user_info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});

  final User user;

  Future<void> logout() async {
    await LocalData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: profileHeader,
      description: profileDescription,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        UserInfo(user: user),
        const SizedBox(
          height: singleSpace * 2,
        ),
        TextButton(
            onPressed: () {
              logout().whenComplete(() => context.go("/"));
            },
            child: const Text(logoutButtonLabel)),
      ]),
    );
  }
}
