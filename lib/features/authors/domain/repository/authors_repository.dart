abstract class AuthorsRepository {
  Future<Map<String, dynamic>> fetchMessages({String? pageToken});
}
