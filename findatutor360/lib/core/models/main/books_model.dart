class Book {
  final String id;
  final String title;
  final String? author;
  final String? description;
  final String? thumbnail;
  final String? publisher;
  final String? category;
  final int? pageCount;
  final String? textSnippet;
  final String? smallThumbnail;
  int quantity;

  Book({
    required this.id,
    required this.title,
    this.author,
    this.description,
    this.thumbnail,
    this.publisher,
    this.category,
    this.pageCount,
    this.textSnippet,
    this.smallThumbnail,
    this.quantity = 1,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final searchInfo = json['searchInfo'] ?? {};
    final id = json['id'];
    return Book(
      id: id,
      title: volumeInfo['title'] ?? 'No Title',
      author: (volumeInfo['authors'] != null)
          ? volumeInfo['authors'].join(', ')
          : 'Unknown Author',
      description: volumeInfo['description'] ?? 'No Description',
      thumbnail: volumeInfo['imageLinks'] != null
          ? volumeInfo['imageLinks']['thumbnail']
          : null,
      publisher: volumeInfo['publisher'] ?? 'No Publisher',
      category: (volumeInfo['categories'] != null)
          ? volumeInfo['categories'].join(', ')
          : 'Unknown',
      pageCount: (volumeInfo['pageCount'] != null)
          ? int.tryParse(volumeInfo['pageCount'].toString()) ?? 0
          : 0,
      textSnippet: searchInfo['textSnippet'] ?? '',
      smallThumbnail: volumeInfo['imageLinks'] != null
          ? volumeInfo['imageLinks']['smallThumbnail']
          : null,
      quantity: 1,
    );
  }
}
