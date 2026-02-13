import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "http://message-list.appspot.com",
  ));

  Future<Response> getMessages({String? pageToken}) async {
    return await dio.get(
      "/messages",
      queryParameters: pageToken != null ? {"pageToken": pageToken} : null,
    );
  }
}
