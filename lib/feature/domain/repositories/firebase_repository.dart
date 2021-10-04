import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignedIn();

  Future<void> signIn(UserEntity userEntity);

  Future<void> signUp(UserEntity userEntity);

  Future<void> signOut();

  Future<String> getCurrentUid();

  Future<void> getCreateCurrentUser(UserEntity userEntity);

  Future<void> addNewNote(NoteEntity noteEntity);

  Future<void> updateNote(NoteEntity noteEntity);

  Future<void> deleteNewNote(NoteEntity noteEntity);

  Stream<List<NoteEntity?>> getNotes(String uid);
}
