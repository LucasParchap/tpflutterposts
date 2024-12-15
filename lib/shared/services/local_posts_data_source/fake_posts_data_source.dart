import 'dart:async';
import '../../models/Post.dart';
import '../posts_data_source/posts_data_source.dart';

class FakePostsDataSource extends PostsDataSource {

  final List<Post> _fakePosts = const [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description of Post 3'),
  ];

  final List<Post> _mutablePosts = [];

  FakePostsDataSource() {
    _mutablePosts.addAll(_fakePosts);
  }

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _mutablePosts.add(postToAdd);
    return postToAdd;
  }
  @override
  Future<Post> updatePost(Post updatedPost) async {
    print('Simulating update in data source');
    await Future.delayed(const Duration(seconds: 10));
    final index = _mutablePosts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _mutablePosts[index] = updatedPost;
      print('Post updated in data source');
    }
    return updatedPost;
  }

}


