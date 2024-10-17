import 'dart:convert';

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
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    final searchInfo = json['searchInfo'];
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
      pageCount: volumeInfo['pageCount'] ?? '0',
      textSnippet: searchInfo['textSnippet'] ?? '',
      smallThumbnail: volumeInfo['imageLinks'] != null
          ? volumeInfo['imageLinks']['smallThumbnail']
          : null,
    );
  }
}

class BookCodec extends Codec<Book, Map<String, dynamic>> {
  const BookCodec();

  @override
  Converter<Map<String, dynamic>, Book> get decoder => const _BookDecoder();

  @override
  Converter<Book, Map<String, dynamic>> get encoder => const _BookEncoder();
}

class _BookDecoder extends Converter<Map<String, dynamic>, Book> {
  const _BookDecoder();

  @override
  Book convert(Map<String, dynamic> input) {
    return Book.fromJson(input);
  }
}

class _BookEncoder extends Converter<Book, Map<String, dynamic>> {
  const _BookEncoder();

  @override
  Map<String, dynamic> convert(Book input) {
    return {
      'id': input.id,
      'title': input.title,
      'author': input.author,
      'description': input.description,
      'thumbnail': input.thumbnail,
      'publisher': input.publisher,
      'category': input.category,
      'pageCount': input.pageCount,
      'textSnippet': input.textSnippet,
      'smallThumbnail': input.smallThumbnail,
    };
  }
}
