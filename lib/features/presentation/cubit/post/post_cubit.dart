import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone_app/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/post/read_posts_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostsUseCase readPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  PostCubit({
    required this.updatePostUseCase,
    required this.deletePostUseCase,
    required this.likePostUseCase,
    required this.createPostUseCase,
    required this.readPostUseCase
}) : super(PostInitial());

  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostUseCase.call(post);
      streamResponse.listen((posts) {
        emit(PostLoaded(posts: posts));
      });
    } on SocketException catch(_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    try {
      await likePostUseCase.call(post);
    } on SocketException catch(_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    try {
      await deletePostUseCase.call(post);
    } on SocketException catch(_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    try {
      await createPostUseCase.call(post);
    } on SocketException catch(_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    try {
      await updatePostUseCase.call(post);
    } on SocketException catch(_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
}
