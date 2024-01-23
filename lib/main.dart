import 'package:firebase_core/firebase_core.dart';
import 'package:friendslocation/data/local/sharedpreference/mypref.dart';
import 'package:friendslocation/getX/state_manager/controller/home_page_controller.dart';
import 'package:friendslocation/getX/state_manager/controller/map_screen_getx_controller.dart';
import 'package:friendslocation/presentation/home_page.dart';
import 'package:friendslocation/util/theme_change.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:friendslocation/presentation/enter_name_screen.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'getX/state_manager/controller/getx_controller.dart';
import 'presentation/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AndroidYandexMap.useAndroidViewSurface = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EnterNameController());
    Get.put(MapScreenGetXController());
    Get.put(HomePageController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: ThemeMode.system,
        // home: MapScreen(),
        initialRoute: MyPref.getName().isNull?"/entername":"/homepage",
        getPages: [
          GetPage(name: "/entername", page: () => EnterNameScreen()),
          GetPage(name: "/mapscreen", page: () => MapScreen()),
          GetPage(name: "/homepage", page: () => HomePage()),
        ]);
  }
}
