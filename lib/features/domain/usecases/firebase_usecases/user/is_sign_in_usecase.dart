
import 'package:instagram_clone_app/features/domain/repository/firebase_repository.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}