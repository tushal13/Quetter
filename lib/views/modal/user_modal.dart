import 'dart:developer';

class UserModal {
  String? name;
  String? email;
  List prefs = [];

  UserModal({required this.name, required this.email, required List prefs});

  UserModal.init() {
    log("Empty user initialized...");
  }

  factory UserModal.fromMap({required Map user}) {
    return UserModal(
      name: user['Name'],
      email: user['Email'],
      prefs: user['prefs'],
    );
  }
}
