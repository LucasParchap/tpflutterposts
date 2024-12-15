import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../models/Post.dart';
import '../../../app_exception.dart';
import '../services/posts_repository/posts_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onGetAllPosts(GetAllPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final posts = await postRepository.getAllPosts();
      emit(state.copyWith(
        posts: posts,
        status: PostStatus.successLoading,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        exception: AppException.from(error),
      ));
    }
  }


  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final createdPost = await postRepository.createPost(event.newPost);
      final updatedPosts = List<Post>.from(state.posts)..add(createdPost);
      emit(state.copyWith(
        posts: updatedPosts,
        status: PostStatus.successCreating,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        exception: AppException.from(error),
      ));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    try {
      final updatedPost = await postRepository.updatePost(event.updatedPost);

      final updatedPosts = state.posts.map((post) {
        return post.id == updatedPost.id ? updatedPost : post;
      }).toList();

      emit(state.copyWith(
        posts: updatedPosts,
        status: PostStatus.successUpdating,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        exception: AppException.from(error),
      ));
    }
  }
  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await postRepository.deletePost(event.postToDelete);
      final updatedPosts = state.posts.where((post) => post.id != event.postToDelete.id).toList();

      emit(state.copyWith(
        posts: updatedPosts,
        status: PostStatus.successDeleting,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        exception: AppException.from(error),
      ));
    }
  }
}
