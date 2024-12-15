part of 'post_bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent();
}

class GetAllPosts extends PostEvent {
  const GetAllPosts();
}

class CreatePost extends PostEvent {
  final Post newPost;

  const CreatePost(this.newPost);

  @override
  List<Object> get props => [newPost];
}

class UpdatePost extends PostEvent {
  final Post updatedPost;

  const UpdatePost({required this.updatedPost});

  @override
  List<Object> get props => [updatedPost];
}

class DeletePost extends PostEvent {
  final String postId;

  const DeletePost({required this.postId});
}
