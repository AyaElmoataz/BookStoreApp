import 'package:book_store_app/features/login/domain/exceptions/network_exception.dart';
import 'package:book_store_app/features/login/domain/exceptions/validation_exception.dart';
import 'package:book_store_app/features/login/domain/services/network_info.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  final NetworkInfo networkInfo;

  LoginUseCase(this.repository, this.networkInfo);

  Future<User> call({required String email, required String password}) async {
    // Validation
    if (email.isEmpty || password.isEmpty) {
      throw ValidationException("Email and password are required.");
    }

    if (!email.contains('@')) {
      throw ValidationException("Invalid email format.");
    }

    // Network check
    if (!await networkInfo.isConnected) {
      throw NetworkException("No internet connection.");
    }

    // Call repository
    return repository.login(email: email, password: password);
  }
}
