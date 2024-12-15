import '../../models/Post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post newPost);
  Future<Post> updatePost(Post updatedPost);
  Future<void> deletePost(Post postToDelete);
}
