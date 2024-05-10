import 'package:flutter/material.dart';
import 'package:flutter_fluentui_getx_desktop/home_detail/view.dart';
import 'package:get/get.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => state.asd.value++,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<HomeLogic>(builder: (logic) {
          return Column(
            children: [
              Row(
                children: [
                  InfoLabel(
                    label: '',
                    child: Button(
                      onPressed: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).push(FluentPageRoute(builder: (context) {
                          return HomeDetailPage();
                        }));
                      },
                      child: const Text('Open in a new screen'),
                    ),
                  ),
                  InfoLabel(
                    label: '',
                    child: Button(
                      onPressed: () {
                        context.push('/home_detail');
                      },
                      child: const Text('Open in a new shell route'),
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
