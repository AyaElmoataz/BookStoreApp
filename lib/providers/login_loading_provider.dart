import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginLoadingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false; // initial state
  }

  void startLoading() {
    state = true;
  }

  void stopLoading() {
    state = false;
  }
}

final loginLoadingProvider = NotifierProvider<LoginLoadingNotifier, bool>(
  LoginLoadingNotifier.new,
);
