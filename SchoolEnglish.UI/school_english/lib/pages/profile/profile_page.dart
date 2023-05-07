import 'package:flutter/material.dart';
import 'package:school_english/helpers/appbar_builder.dart';
import 'package:school_english/pages/profile/components/profile_body.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context),
      body: const ProfileBody(),
    );
  }
}
