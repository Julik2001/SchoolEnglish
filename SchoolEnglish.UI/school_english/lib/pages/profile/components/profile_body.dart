import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/pages/components/appbar_builder.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  Future<void> logout() async {
    await LocalData.saveJwt("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      margin: const EdgeInsets.all(singleSpace),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileHeader,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text(
              profileDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            TextButton(
                onPressed: () {
                  logout().whenComplete(() => context.go("/"));
                },
                child: Text(logoutButtonLabel)),
          ],
        ),
      ),
    );
  }
}
