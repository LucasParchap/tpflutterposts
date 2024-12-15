part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  successLoading,
  successCreating,
  error
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final AppException? exception;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.exception,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    AppException? exception,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception,
    );
  }
}
