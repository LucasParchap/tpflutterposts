import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_detail_screen.dart';
import '../../shared/blocs/post_bloc.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.successLoading) {
            if (state.posts.isEmpty) {
              return Center(child: Text('Aucun post disponible.'));
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
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Center(child: Text('Aucun état valide.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'écran de création de post
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
