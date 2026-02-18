import 'package:book_store_app/controllers/login_controller.dart';
import 'package:book_store_app/services/network_service.dart';
import 'package:book_store_app/utils/auth_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockNetworkService extends Mock implements NetworkService {}

class MockValidators extends Mock implements AuthValidators {}

class MockUserCredentials extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockNetworkService mockNetworkService;
  late MockValidators mockValidators;
  late MockUserCredentials mockUserCredentials;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockNetworkService = MockNetworkService();
    mockValidators = MockValidators();
    mockUserCredentials = MockUserCredentials();
  });

  test(
    'login successfully if validation passes, and network check passes',
    () async {
      when(() => mockValidators.validateAuth(any(), any())).thenReturn(null);

      when(
        () => mockNetworkService.isConnected(),
      ).thenAnswer((_) async => true);

      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => mockUserCredentials);
    },
  );
}
