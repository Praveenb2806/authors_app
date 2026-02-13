import 'author_model.dart';

class MessageModel {
  final int id;
  final String content;
  final DateTime updated;
  final AuthorModel author;
  bool isFavourite;

  MessageModel({
    required this.id,
    required this.content,
    required this.updated,
    required this.author,
    this.isFavourite = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      updated: DateTime.parse(json['updated']),
      author: AuthorModel.fromJson(json['author']),
    );
  }
}
