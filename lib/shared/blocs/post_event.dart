part of 'post_bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent();
}

class GetAllPosts extends PostEvent {
  const GetAllPosts();
}

class AddPost extends PostEvent {
  final Post post;

  const AddPost({required this.post});
}

class UpdatePost extends PostEvent {
  final Post updatedPost;

  const UpdatePost({required this.updatedPost});
}

class DeletePost extends PostEvent {
  final String postId;

  const DeletePost({required this.postId});
}
