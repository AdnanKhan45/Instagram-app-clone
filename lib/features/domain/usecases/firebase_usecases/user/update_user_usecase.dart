
import 'package:instagram_clone_app/features/domain/entities/user/user_entity.dart';

import '../../../repository/firebase_repository.dart';

class UpdateUserUseCase {
  final FirebaseRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.updateUser(userEntity);
  }
}