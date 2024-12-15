import 'dart:async';
import '../../models/Post.dart';
import '../posts_data_source/posts_data_source.dart';


class FakePostsDataSource extends PostsDataSource {
  final List<Post> _fakePosts = const [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description of Post 3'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }
}

