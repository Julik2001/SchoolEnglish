import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/helpers/appbar_builder.dart';
import 'package:school_english/models/user/user.dart';
import 'package:school_english/pages/error/error_page.dart';
import 'package:school_english/pages/profile/components/profile_body.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User?> user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = Api.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context, () => context.go("/")),
      body: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.requireData != null) {
            return ProfileBody(
              user: snapshot.requireData!,
            );
          } else if (snapshot.hasError) {
            return const ErrorPage();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
