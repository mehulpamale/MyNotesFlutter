import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository firebaseRepository;

  GetCreateCurrentUserUseCase(this.firebaseRepository);

  Future<void> call(UserEntity userEntity) async {
    return firebaseRepository.getCreateCurrentUser(userEntity);
  }
}
