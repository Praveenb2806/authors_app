import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message_model.dart';
import '../bloc/author_bloc.dart';
import '../bloc/author_event.dart' show DeleteAuthor, ToggleFavourite;
import 'package:intl/intl.dart';

import '../screens/author_detail_screen.dart';

class AuthorTile extends StatelessWidget {
  final MessageModel author;

  const AuthorTile({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            "http://message-list.appspot.com${author.author.photoUrl}",
          ),
        ),
        title: Text(author.author.name),
        subtitle: Text(
          DateFormat.yMMMd().format(author.updated),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                author.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                context
                    .read<AuthorsBloc>()
                    .add(ToggleFavourite(author.id));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showDeleteDialog(context),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AuthorDetailScreen(author: author),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Author"),
        content:
        const Text("Are you sure you want to delete this author?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<AuthorsBloc>()
                  .add(DeleteAuthor(author.id));
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
