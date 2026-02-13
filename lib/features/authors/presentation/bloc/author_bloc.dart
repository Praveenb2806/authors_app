import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message_model.dart';
import '../../domain/repository/authors_repository.dart';
import 'author_event.dart';
import 'author_state.dart';

class AuthorsBloc extends Bloc<AuthorsEvent, AuthorsState> {
  final AuthorsRepository repository;

  AuthorsBloc(this.repository) : super(const AuthorsState()) {
    on<FetchAuthors>(_onFetchAuthors);
    on<FetchMoreAuthors>(_onFetchMoreAuthors);
    on<SearchAuthors>(_onSearchAuthors);
    on<DeleteAuthor>(_onDeleteAuthor);
    on<ToggleFavourite>(_onToggleFavourite);
  }

  Future<void> _onFetchAuthors(
      FetchAuthors event, Emitter<AuthorsState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final data = await repository.fetchMessages();
      final messages = (data['messages'] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();

      emit(state.copyWith(
        authors: messages,
        nextPageToken: data['pageToken'],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchMoreAuthors(
      FetchMoreAuthors event, Emitter<AuthorsState> emit) async {

    if (state.isPaginationLoading || state.nextPageToken == null) return;

    emit(state.copyWith(isPaginationLoading: true));

    try {
      final data =
      await repository.fetchMessages(pageToken: state.nextPageToken);

      final moreMessages = (data['messages'] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();

      final existingIds = state.authors.map((e) => e.id).toSet();

      final filteredNewMessages = moreMessages
          .where((msg) => !existingIds.contains(msg.id))
          .toList();

      print("Fetched ${filteredNewMessages.length} items");
      print("Old Total: ${state.authors.length}");
      print("New Total: ${state.authors.length + filteredNewMessages.length}");

      emit(state.copyWith(
        authors: [...state.authors, ...filteredNewMessages],
        nextPageToken: data['pageToken'],
        isPaginationLoading: false,
      ));

    } catch (e) {
      emit(state.copyWith(isPaginationLoading: false));
    }
  }

  void _onSearchAuthors(SearchAuthors event, Emitter<AuthorsState> emit) {
    final filtered = state.authors
        .where((author) =>
        author.author.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(authors: filtered));
  }

  void _onDeleteAuthor(DeleteAuthor event, Emitter<AuthorsState> emit) {

    final updated =
    state.authors.where((a) => a.id != event.id).toList();

    print("Deleted ID: ${event.id}");
    print("Old Count: ${state.authors.length}");
    print("New Count: ${updated.length}");

    emit(state.copyWith(authors: updated));
  }


  void _onToggleFavourite(
      ToggleFavourite event, Emitter<AuthorsState> emit) {

    final updated = state.authors.map((a) {
      if (a.id == event.id) {
        return MessageModel(
          id: a.id,
          content: a.content,
          updated: a.updated,
          author: a.author,
          isFavourite: !a.isFavourite,
        );
      }
      return a;
    }).toList();

    emit(state.copyWith(authors: updated));
  }

}
