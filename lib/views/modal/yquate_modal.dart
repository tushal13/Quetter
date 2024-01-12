import 'dart:developer';

class YourModal {
  String? quote;
  String? author;

  YourModal(
    this.quote,
    this.author,
  );
  YourModal.init() {
    log("Empty q initialized...");
  }

  factory YourModal.fromMap({required Map quote}) {
    return YourModal(
      quote['Quotes'],
      quote['Author'],
    );
  }
}
