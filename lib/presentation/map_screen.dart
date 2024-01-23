import 'dart:async';

import 'package:flutter/material.dart';
import 'package:friendslocation/repository/repository.dart';
import 'package:friendslocation/util/app_lat_long.dart';
import 'package:friendslocation/util/location_service.dart';
import 'package:get/get.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../api_service.dart';
import '../getX/state_manager/controller/map_screen_getx_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final mapGetxController = Get.find<MapScreenGetXController>();
  final List<MapObject> mapObjects = [];

  // void getBranches() async {
  //   final result = await ApiService().getBranches();
  //
  //   for (var element in result.data.data[0].openedStores) {
  //     print(element.name);
  //     //print();
  //     mapObjects.add(PlacemarkMapObject(
  //         mapId: MapObjectId(element.id.toString()),
  //         icon: PlacemarkIcon.single(PlacemarkIconStyle(
  //             scale: 0.8,
  //             image: BitmapDescriptor.fromAssetImage('assets/btn2.bmp'))),
  //         point: Point(
  //             latitude: double.parse(element.lat),
  //             longitude: double.parse(element.long))));
  //   }
  //   // _moveToCurrentLocation(double.parse(result.data.data.first.openedStores.first.lat), double.parse(result.data.data.first.openedStores.first.long));
  //   /*setState(() {
  //
  //   });*/
  // }

  void getFriends() async {
    final repository = AppRepository();
    var resualt = await repository.getFriendLocation();
    print("${resualt.length}");
    for (var friend in resualt) {
      mapObjects.add(PlacemarkMapObject(
          text: PlacemarkText(
            text: friend.name ?? "null",
            style: const PlacemarkTextStyle(
                size: 10, placement: TextStylePlacement.bottom),
          ),
          mapId: MapObjectId(friend.mapId.toString()),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              scale: 0.1,
              image: BitmapDescriptor.fromAssetImage('assets/btn.png'))),
          point:
              Point(latitude: friend.late ?? 0, longitude: friend.long ?? 0)));
      setState(() {});
    }
  }

  @override
  void dispose() {
    mapGetxController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _initPermission();
    //mapGetxController.getAllFriends();
    // getBranches();
    getFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: YandexMap(
            onMapCreated: (controller) {
              mapControllerCompleter.complete(controller);
            },
            onMapTap: (point) {
              print('LAT ----------------------');
              print(point.latitude);
            },
            onObjectTap: (geoObject) {
              print('NAMEEE -[-------------------');
              print(geoObject.name);
            },
            zoomGesturesEnabled: true,
            mapObjects:
                mapObjects /*[
          PlacemarkMapObject(
            onTap: (object, point) {
              print('Object tappeppp');
              print(object.mapId.value);
            },
            text: PlacemarkText(
                text: "BUTTON", style: PlacemarkTextStyle(size: 12,placement: TextStylePlacement.bottom)),
            mapId: MapObjectId('154'),
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                scale: 0.8,
                image: BitmapDescriptor.fromAssetImage('assets/btn.png'))),
            point: Point(latitude: 41.311081, longitude: 69.240562))

        ],*/
            ));
  }
}
