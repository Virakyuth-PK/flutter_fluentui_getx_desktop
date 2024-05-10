import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class Home1Page extends StatelessWidget {
  Home1Page({Key? key}) : super(key: key);

  final logic = Get.put(Home1Logic());
  final state = Get.find<Home1Logic>().state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home 1"),
    );
  }
}
