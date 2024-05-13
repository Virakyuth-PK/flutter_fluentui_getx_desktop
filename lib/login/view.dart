import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.put(LoginLogic());

  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text("Login"),
            TextButton(
              onPressed: () async {
                await logic.login();
                context.push("/home");
              },
              child: Text("go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
