import 'package:fluent_ui/fluent_ui.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'logic.dart';

class HomeDetailPage extends StatelessWidget {
  HomeDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(HomeDetailLogic());
  final state = Get.find<HomeDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          const title = Text('Home Detail');
          return const DragToMoveArea(child: title);
        }(),
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => context.pop(),
        ),
      ),
      content: const ScaffoldPage(
        header: PageHeader(
          title: Text('Home Detail'),
        ),
        content: Center(
          child: Text('This is a new page'),
        ),
      ),
    );
  }
}
