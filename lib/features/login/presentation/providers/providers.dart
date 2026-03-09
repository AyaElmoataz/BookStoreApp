import 'package:book_store_app/features/login/data/repositories/auth_repository_impl.dart'
    show AuthRepositoryImpl;
import 'package:book_store_app/features/login/data/services/network_info_impl.dart';
import 'package:book_store_app/features/login/domain/entities/user.dart';
import 'package:book_store_app/features/login/domain/repositories/auth_repository.dart';
import 'package:book_store_app/features/login/domain/services/network_info.dart';
import 'package:book_store_app/features/login/domain/usecases/login_usecase.dart';
import 'package:book_store_app/features/login/presentation/controllers/login_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<firebase_auth.FirebaseAuth>(
  (ref) => firebase_auth.FirebaseAuth.instance,
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepositoryImpl(firebaseAuth);
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(Connectivity());
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return LoginUseCase(repository, networkInfo);
});

final loginControllerProvider = AsyncNotifierProvider<LoginController, User?>(
  LoginController.new,
);
