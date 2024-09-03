import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authstatus;
    });
  }

  AuthStatus _authStatus = AuthStatus.checking;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }

  AuthStatus get authStatus => _authStatus;
}
