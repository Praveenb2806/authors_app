import '../../../../core/network/api_client.dart';

class AuthorsRemoteDataSource {
  final ApiClient apiClient;

  AuthorsRemoteDataSource(this.apiClient);

  Future<Map<String, dynamic>> fetchMessages({String? pageToken}) async {
    final response = await apiClient.getMessages(pageToken: pageToken);
    return response.data;
  }
}
