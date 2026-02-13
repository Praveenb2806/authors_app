import 'package:equatable/equatable.dart';

abstract class AuthorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAuthors extends AuthorsEvent {}

class FetchMoreAuthors extends AuthorsEvent {}

class SearchAuthors extends AuthorsEvent {
  final String query;

  SearchAuthors(this.query);

  @override
  List<Object?> get props => [query];
}

class DeleteAuthor extends AuthorsEvent {
  final int id;

  DeleteAuthor(this.id);
}

class ToggleFavourite extends AuthorsEvent {
  final int id;

  ToggleFavourite(this.id);
}
