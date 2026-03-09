import 'package:book_store_app/features/login/domain/entities/user.dart';
import 'package:book_store_app/features/login/domain/usecases/login_usecase.dart';
import 'package:book_store_app/features/login/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends AsyncNotifier<User?> {
  late final LoginUseCase _loginUseCase;

  @override
  Future<User?> build() async {
    _loginUseCase = ref.read(loginUseCaseProvider);
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _loginUseCase(email: email, password: password);
    });
  }
}
