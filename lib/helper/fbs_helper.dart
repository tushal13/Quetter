import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'fb_auth_helper.dart';

class FBSHelper {
  late FirebaseFirestore firestore;
  late FirebaseStorage storage;

  String usersCollection = 'Users';

  late String currentUser =
      FBAuthHelper.fbAuthHelper.auth.currentUser!.displayName!;

  FBSHelper._init() {
    firestore = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
  }

  static final FBSHelper fbsHelper = FBSHelper._init();

  Future<String?> uploadImage({required String imageUrl}) async {
    String fileName = 'Background/${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference ref = storage.ref(fileName);
    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List imageData = response.bodyBytes;
    await ref.putData(imageData);

    return ref.fullPath;
  }

  addBackground({required String image}) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Background')
        .doc('Background')
        .set({
      'images': image,
    });
  }

  addPurchased({
    required String imageUrl,
  }) async {
    String? image = await uploadImage(imageUrl: imageUrl);
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Purchased')
        .doc('Purchased')
        .set({
      'images': FieldValue.arrayUnion([image]),
    });
  }

  updatePurchesed({
    required String imageUrl,
  }) async {
    String? image = await uploadImage(imageUrl: imageUrl);
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Purchased')
        .doc('Purchased')
        .update({
      'images': FieldValue.arrayUnion([image]),
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchPurchesed() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Purchased')
        .doc('Purchased')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchBackground() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Background')
        .doc('Background')
        .snapshots();
  }
}
