import 'package:equatable/equatable.dart';
import '../../data/models/message_model.dart';

class AuthorsState extends Equatable {
  final List<MessageModel> authors;
  final bool isLoading;
  final bool isPaginationLoading;
  final String? nextPageToken;
  final String? error;

  const AuthorsState({
    this.authors = const [],
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.nextPageToken,
    this.error,
  });

  AuthorsState copyWith({
    List<MessageModel>? authors,
    bool? isLoading,
    bool? isPaginationLoading,
    String? nextPageToken,
    String? error,
  }) {
    return AuthorsState(
      authors: authors ?? this.authors,
      isLoading: isLoading ?? this.isLoading,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      nextPageToken: nextPageToken ?? this.nextPageToken,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [authors, isLoading, isPaginationLoading, nextPageToken, error];
}
