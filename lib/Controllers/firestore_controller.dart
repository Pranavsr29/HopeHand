import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';//Imports the GetX package for state management and routing

class FirestoreController extends GetxController {
  RxBool loader = false.obs;

  Stream<QuerySnapshot> getData(String collectionName) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots();
  }

  Future<void> addData(Map<String, dynamic> data, String id, String collectionName) async {
    try {
      loader.value = true;
      update();
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .set(data)
          .then((_) {
        loader.value = false;
        update();
      });
    } catch (e) {
      loader.value = false;
      update();
      print(e.toString());
    }
  }

  Future<void> deleteData(String id, String collectionName) async {
    loader.value = true;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete()
        .then((_) {
      loader.value = false;
    }).onError((error, stackTrace) {
      loader.value = false;
      Get.snackbar('error', 'Something went wrong');
      print(error);
    });
  }

  Future<void> updateData(String id, Map<String, dynamic> itemDetails, String collection) async {
    loader.value = true;
    final docRef = FirebaseFirestore.instance.collection(collection).doc(id);
    final doc = await docRef.get();

    if (doc.exists) {
      loader.value = false;
      await docRef.update(itemDetails).then((_) {
        Get.back();
      });
    } else {
      loader.value = false;
      print('Document does not exist');
    }
  }
  Future<QuerySnapshot> getDataOnce(String collection) async {
    return await FirebaseFirestore.instance.collection(collection).get();
  }

}
