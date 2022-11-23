import 'package:instagram_clone_app/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone_app/features/domain/repository/firebase_repository.dart';

class ReadPostsUseCase {
  final FirebaseRepository repository;

  ReadPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}