import '../../models/Post.dart';
import '../posts_data_source/posts_data_source.dart';

class PostRepository {
  final PostsDataSource postsDataSource;

  PostRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts() async {
    return await postsDataSource.getAllPosts();
  }
}
