import 'package:cloud_firestore/cloud_firestore.dart';

import '../views/modal/quate_modal.dart';
import '../views/modal/user_modal.dart';
import 'fb_auth_helper.dart';

class FbStoreHelper {
  FbStoreHelper._();

  static final FbStoreHelper fbStoreHelper = FbStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String usersCollection = 'Users';
  String allusersCollection = 'AllUsers';

  late String currentUser =
      FBAuthHelper.fbAuthHelper.auth.currentUser!.displayName!;

  addUser({required UserModal user}) async {
    await firestore.collection(allusersCollection).doc(user.name).set({
      'email': user.email,
      'name': user.name,
      'Prefrance': user.prefs,
    });
  }

  updateUser({required UserModal user}) async {
    await firestore.collection(allusersCollection).doc(user.name).update({
      'email': user.email,
      'name': user.name,
      'Prefrance': user.prefs,
    });
  }

  addPrefrance({required UserModal user}) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Prefrance')
        .doc('Prefrance')
        .set({'Prefrance': user.prefs});
  }

  addCoins({
    required int coins,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Coins')
        .doc('Coins')
        .set({
      'Coins': FieldValue.increment(coins),
    });
  }

  upadateCoins({
    required int coins,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Coins')
        .doc('Coins')
        .update({
      'Coins': FieldValue.increment(coins),
    });
  }

  decrementCoins({
    required int coins,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Coins')
        .doc('Coins')
        .update({
      'Coins': FieldValue.increment(-coins),
    });
  }

  Future<void> addFavorite({required QuoteModal quote}) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Favorites')
        .doc(quote.id.toString())
        .set({
      'Id': quote.id,
      'Quotes': quote.quote,
      'Author': quote.author,
      'Category': quote.category,
      'Image': quote.image,
    });
  }

  Future<void> addQuote({
    required String quote,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Quotes')
        .doc(quote)
        .set({
      'Quotes': quote,
      'Author': currentUser,
    });
  }

  Future<void> addHistory({
    required QuoteModal quote,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('PastQuotes')
        .doc(quote.id.toString())
        .set({
      'Id': quote.id,
      'Quotes': quote.quote,
      'Author': quote.author,
      'Category': quote.category,
      'Image': quote.image,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchHistory() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('PastQuotes')
        .snapshots();
  }

  Stream fetchyourQuotes() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Quotes')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchPrefrance() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Prefrance')
        .doc('Prefrance')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchCoins() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Coins')
        .doc('Coins')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchFavorites() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Favorites')
        .snapshots();
  }
}
