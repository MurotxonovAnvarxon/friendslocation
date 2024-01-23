import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/friend_model.dart';

class AppRepository {
  final collectionreference = FirebaseFirestore.instance.collection('friends');

  Future<bool> sendlocation(Autogenerated data) async {
   await collectionreference.doc(data.mapId).set(data.toJson());
    return true;
  }

  Future<List<Autogenerated>> getFriendLocation() async {
    List<Autogenerated> users = [];

    try {
      QuerySnapshot snapshot = await collectionreference.get();
      users = snapshot.docs.map((doc) {
        return Autogenerated.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      print(users[0].name);
      return users;
    } catch (e) {
      print("Error getting all users: $e");
      return [];
    }
  }

  Future<bool> updateLocation(Autogenerated friendModel) async {
    try {
     await collectionreference.doc("${friendModel.mapId}${friendModel.name}").update(friendModel.toJson());
      return true;
    } catch (e) {
      print('Error updating location: $e');
      return false;
    }
  }
}
