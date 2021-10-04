import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';

class SignOutUseCase {
  final FirebaseRepository firebaseRepository;

  SignOutUseCase(this.firebaseRepository);

  Future<void> call() async {
    return firebaseRepository.signOut();
  }
}
