import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/themes/typography.dart';
import '../../../core/themes/colors.dart';

class SessionCubit extends Cubit<SessionState> {
  final Box _authBox;

  SessionCubit()
      : _authBox = Hive.box('auth'),
        super(SessionState.initial());

  void loadSession() {
    final userId = _authBox.get('userId');
    final username = _authBox.get('username');
    final role = _authBox.get('role');

    if (userId != null && username != null && role != null) {
      emit(SessionState.authenticated(
        userId: userId,
        username: username,
        role: role,
      ));
    } else {
      emit(SessionState.unauthenticated());
    }
  }

  void login({
    required String userId,
    required String username,
    required String role,
  }) {
    _authBox.put('userId', userId);
    _authBox.put('username', username);
    _authBox.put('role', role);

    emit(SessionState.authenticated(
      userId: userId,
      username: username,
      role: role,
    ));
  }

  void logout() {
    _authBox.delete('userId');
    _authBox.delete('username');
    _authBox.delete('role');

    emit(SessionState.unauthenticated());
  }

  void updateRole(String role) {
    _authBox.put('role', role);
    final currentState = state;
    if (currentState is AuthenticatedSession) {
      emit(currentState.copyWith(role: role));
    }
  }

  bool get isAuthenticated => state is AuthenticatedSession;
  bool get isAdmin => state is AuthenticatedSession && state.role == 'admin';
  bool get isTrainer =>
      state is AuthenticatedSession && state.role == 'trainer';
  bool get isAccountant =>
      state is AuthenticatedSession && state.role == 'accountant';
}

// Session States
abstract class SessionState {
  const SessionState();

  factory SessionState.initial() = InitialSession;
  factory SessionState.authenticated({
    required String userId,
    required String username,
    required String role,
  }) = AuthenticatedSession;
  factory SessionState.unauthenticated() = UnauthenticatedSession;
}

class InitialSession extends SessionState {
  const InitialSession();
}

class AuthenticatedSession extends SessionState {
  final String userId;
  final String username;
  final String role;

  const AuthenticatedSession({
    required this.userId,
    required this.username,
    required this.role,
  });

  AuthenticatedSession copyWith({
    String? userId,
    String? username,
    String? role,
  }) {
    return AuthenticatedSession(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      role: role ?? this.role,
    );
  }
}

class UnauthenticatedSession extends SessionState {
  const UnauthenticatedSession();
}