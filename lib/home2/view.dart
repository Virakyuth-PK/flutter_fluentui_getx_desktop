import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class Home2Page extends StatelessWidget {
  Home2Page({Key? key}) : super(key: key);

  final logic = Get.put(Home2Logic());
  final state = Get.find<Home2Logic>().state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home 2"),
    );
  }
}
