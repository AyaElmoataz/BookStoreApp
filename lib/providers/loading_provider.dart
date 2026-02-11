import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends Notifier<bool> {
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

final loadingProvider = NotifierProvider<LoadingNotifier, bool>(
  LoadingNotifier.new,
);
