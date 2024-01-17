import 'package:firebase_core/firebase_core.dart';
import 'package:friendslocation/getX/state_manager/controller/map_screen_getx_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:friendslocation/presentation/enter_name_screen.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'getX/state_manager/controller/getx_controller.dart';
import 'presentation/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AndroidYandexMap.useAndroidViewSurface = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(EnterNameController());
    Get.put(MapScreenGetXController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: MapScreen(),
        initialRoute: "/entername",
        getPages: [
          GetPage(name: "/entername", page: () => EnterNameScreen()),
          GetPage(name: "/mapscreen", page: () => MapScreen()),
        ]);
  }
}
