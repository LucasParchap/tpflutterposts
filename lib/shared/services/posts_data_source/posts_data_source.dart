import '../../models/Post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();
}