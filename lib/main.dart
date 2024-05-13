import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fluentui_getx_desktop/home1/logic.dart';
import 'package:flutter_fluentui_getx_desktop/home1/view.dart';
import 'package:flutter_fluentui_getx_desktop/home2/logic.dart';
import 'package:flutter_fluentui_getx_desktop/home2/view.dart';
import 'package:flutter_fluentui_getx_desktop/home_detail/logic.dart';
import 'package:flutter_fluentui_getx_desktop/home_detail/view.dart';
import 'package:flutter_fluentui_getx_desktop/login/logic.dart';
import 'package:flutter_fluentui_getx_desktop/login/view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:system_theme/system_theme.dart';
import '../../setting/logic.dart';
import '../../setting/view.dart';
import '../../theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

import 'home/logic.dart';
import 'home/view.dart';
import 'main_app_page.dart';
import 'service.dart';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoginLogic());
  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await flutter_acrylic.Window.hideWindowControls();
    }
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(500, 600));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(true);
    });
  }

  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppTheme>(builder: (logic) {
      return FluentApp.router(
        title: appTitle,
        themeMode: Get.find<AppTheme>().mode,
        debugShowCheckedModeBanner: false,
        color: Get.find<AppTheme>().color,
        darkTheme: FluentThemeData(
          brightness: Brightness.dark,
          accentColor: Get.find<AppTheme>().color,
          visualDensity: VisualDensity.standard,
          focusTheme: FocusThemeData(
            glowFactor: is10footScreen(context) ? 2.0 : 0.0,
          ),
        ),
        theme: FluentThemeData(
          accentColor: Get.find<AppTheme>().color,
          visualDensity: VisualDensity.standard,
          focusTheme: FocusThemeData(
            glowFactor: is10footScreen(context) ? 2.0 : 0.0,
          ),
        ),
        locale: Get.find<AppTheme>().locale,
        builder: (context, child) {
          return Directionality(
            textDirection: Get.find<AppTheme>().textDirection,
            child: NavigationPaneTheme(
              data: NavigationPaneThemeData(
                backgroundColor: Get.find<AppTheme>().windowEffect !=
                        flutter_acrylic.WindowEffect.disabled
                    ? Colors.transparent
                    : null,
              ),
              child: child!,
            ),
          );
        },
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      );
    });
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        // Check if the user is logged in
        if (Get.find<LoginLogic>().state.isLogin.value == true) {
          // If logged in, navigate to the main page
          return MainAppPage(
            shellContext: _shellNavigatorKey.currentContext,
            child: child,
          );
        } else {
          // If not logged in, navigate to the login page
          return LoginPage();
        }
      },
      routes: [
        /// Home
        GoRoute(
            path: '/',
            builder: (context, state) {
              Get.lazyPut(() => LoginLogic());
              return LoginPage();
            }),
        GoRoute(
            path: '/home',
            builder: (context, state) {
              Get.lazyPut(() => HomeLogic());
              return HomePage();
            }),
        GoRoute(
            path: '/settings',
            builder: (context, state) {
              Get.lazyPut(() => SettingLogic());
              return SettingPage();
            }),
        GoRoute(
            path: '/home1',
            builder: (context, state) {
              Get.lazyPut(() => Home1Logic());
              return Home1Page();
            }),
        GoRoute(
            path: '/home2',
            builder: (context, state) {
              Get.lazyPut(() => Home2Logic());
              return Home2Page();
            }),
        GoRoute(
            path: '/home_detail',
            builder: (context, state) {
              Get.lazyPut(() => HomeDetailLogic());
              return HomeDetailPage();
            }),
      ],
    ),
  ],
);
