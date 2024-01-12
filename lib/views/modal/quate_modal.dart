import 'dart:developer';

class QuoteModal {
  String? id;
  String? quote;
  String? author;
  List? category;
  String? image;

  QuoteModal(
    this.id,
    this.quote,
    this.author,
    this.category,
    this.image,
  );
  QuoteModal.init() {
    log("Empty FavQuote initialized...");
  }

  factory QuoteModal.fromMAp({required Map quote}) {
    return QuoteModal(
      quote['Id'],
      quote['Quotes'],
      quote['Author'],
      quote['Category'],
      quote['Image'],
    );
  }
}
