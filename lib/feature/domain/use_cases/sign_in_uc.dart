import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';

class SignInUseCase {
  final FirebaseRepository firebaseRepository;

  SignInUseCase(this.firebaseRepository);

  Future<void> call(UserEntity userEntity) async {
    return firebaseRepository.signIn(userEntity);
  }
}
