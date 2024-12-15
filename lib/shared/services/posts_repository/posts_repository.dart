import '../../models/Post.dart';
import '../posts_data_source/posts_data_source.dart';

class PostRepository {
  final PostsDataSource postsDataSource;

  PostRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts() async {
    return await postsDataSource.getAllPosts();
  }
  Future<Post> createPost(Post newPost) async {
    return await postsDataSource.createPost(newPost);
  }
  Future<Post> updatePost(Post updatedPost) async {
    return await postsDataSource.updatePost(updatedPost);
  }
}
