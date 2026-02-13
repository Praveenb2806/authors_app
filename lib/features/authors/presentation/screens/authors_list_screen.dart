import 'package:authors_app/features/authors/presentation/bloc/author_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/author_bloc.dart';
import '../bloc/author_state.dart';
import '../widgets/author_tile.dart';

class AuthorsListScreen extends StatefulWidget {
  const AuthorsListScreen({super.key});

  @override
  State<AuthorsListScreen> createState() => _AuthorsListScreenState();
}

class _AuthorsListScreenState extends State<AuthorsListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final bloc = context.read<AuthorsBloc>();
      final state = bloc.state;

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !state.isPaginationLoading &&
          state.nextPageToken != null) {
        bloc.add(FetchMoreAuthors());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authors")),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<AuthorsBloc, AuthorsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthorsBloc>().add(FetchAuthors());
                      },
                      child: const Text("Retry"),
                    ),
                  );
                }

                if (state.authors.isEmpty) {
                  return const Center(child: Text("No Authors Found"));
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      state.authors.length +
                      (state.isPaginationLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.authors.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return AuthorTile(author: state.authors[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: "Search authors...",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          context.read<AuthorsBloc>().add(SearchAuthors(value));
        },
      ),
    );
  }
}
