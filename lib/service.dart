// import 'package:cmrt_mobile_app/core/app/logic.dart';
// import 'package:cmrt_mobile_app/core/utils/app_log.dart';
// import 'package:logger/logger.dart';
import '../../theme.dart';

// import '../local_config/hive_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'home/logic.dart';

initServices() async {
  // xLog(message: "Starting services ⚙️");

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  // await Get.put(HiveManager.init(), permanent: true);
  // xLog(message: "DB Done ✅");
  // Get.lazyPut(() => HomeLogic());
  Get.put(AppTheme(), permanent: true);
  // xLog(message: "Theme Done ✅");

  // xLog(message: "All services started ✅");
}
