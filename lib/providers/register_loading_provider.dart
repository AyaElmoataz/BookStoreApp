import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterLoadingNotifier extends Notifier<bool> {
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

final registerLoadingProvider = NotifierProvider<RegisterLoadingNotifier, bool>(
  RegisterLoadingNotifier.new,
);
