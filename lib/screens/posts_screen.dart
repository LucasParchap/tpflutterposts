import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_detail_screen.dart';
import '../../shared/blocs/post_bloc.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Posts'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              if (state.status == PostStatus.successUpdating) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post modifié avec succès !')),
                );
              } else if (state.status == PostStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception?.message ?? 'Une erreur est survenue')),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state.status == PostStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == PostStatus.successLoading ||
                state.status == PostStatus.successCreating ||
                state.status == PostStatus.successUpdating) {
              if (state.posts.isEmpty) {
                return const Center(child: Text('Aucun post disponible.'));
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(post: post),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state.status == PostStatus.error) {
              return Center(
                child: Text(
                  state.exception?.message ?? 'Une erreur est survenue',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state.status == PostStatus.initial) {
              return const Center(child: Text('Chargement des posts...'));
            }
            return const Center(child: Text('Aucun état valide.'));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createPost');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
