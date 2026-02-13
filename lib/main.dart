import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/api_client.dart';
import 'features/authors/data/datasource/authors_remote_data_source.dart';
import 'features/authors/data/repository/authors_repository_impl.dart';
import 'features/authors/presentation/bloc/author_bloc.dart';
import 'features/authors/presentation/bloc/author_event.dart';
import 'features/authors/presentation/screens/authors_list_screen.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = AuthorsRemoteDataSource(apiClient);
  final repository = AuthorsRepositoryImpl(remoteDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthorsRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => AuthorsBloc(repository)..add(FetchAuthors()),
        child: const AuthorsListScreen(),
      ),
    );
  }
}
