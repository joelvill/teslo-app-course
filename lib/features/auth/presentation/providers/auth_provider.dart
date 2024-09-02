// State

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}

  void _setLoggedUser(User user) {
    // TODO: guardar el token
    state = state.copyWith(
      user: user,
      errorMessage: '',
      authstatus: AurhStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // TODO: limpiar el token
    state = state.copyWith(
      user: null,
      errorMessage: errorMessage ?? '',
      authstatus: AurhStatus.notAuthenticated,
    );
  }
}

enum AurhStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AurhStatus authstatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authstatus = AurhStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AurhStatus? authstatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      authstatus: authstatus ?? this.authstatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
