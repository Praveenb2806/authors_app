import '../../domain/repository/authors_repository.dart';
import '../datasource/authors_remote_data_source.dart';

class AuthorsRepositoryImpl implements AuthorsRepository {
  final AuthorsRemoteDataSource remoteDataSource;

  AuthorsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> fetchMessages({String? pageToken}) {
    return remoteDataSource.fetchMessages(pageToken: pageToken);
  }
}
