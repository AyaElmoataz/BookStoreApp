import 'package:book_store_app/features/login/data/mappers/auth_error_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = credential.user!;

      return User(id: firebaseUser.uid, email: firebaseUser.email ?? '');
    } on FirebaseAuthException catch (e) {
      throw AuthErrorMapper.map(e);
    }
  }
}
