import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gym_buffet_manager/presentation/blocs/auth/auth_bloc.dart';

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, equals(const AuthInitial()));
    });

    group('AuthLoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthAuthenticated] on successful login',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const AuthLoginRequested(
          username: 'admin',
          password: 'admin123',
        )),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthAuthenticated>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] on invalid credentials',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const AuthLoginRequested(
          username: 'wrong',
          password: 'wrong',
        )),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthError>(),
        ],
      );
    });

    group('AuthLogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthUnauthenticated] on logout',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthUnauthenticated>(),
        ],
      );
    });

    group('AuthLockScreenRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit AuthLocked when lock screen requested',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const AuthLockScreenRequested()),
        expect: () => [
          isA<AuthLocked>(),
        ],
      );
    });

    group('AuthCheckStatusRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit AuthUnauthenticated when no session exists',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const AuthCheckStatusRequested()),
        expect: () => [
          isA<AuthUnauthenticated>(),
        ],
      );
    });

    test('should track failed login attempts', () async {
      // First failed attempt
      authBloc.add(const AuthLoginRequested(
        username: 'wrong',
        password: 'wrong',
      ));
      await Future.delayed(const Duration(milliseconds: 100));

      // Second failed attempt
      authBloc.add(const AuthLoginRequested(
        username: 'wrong',
        password: 'wrong',
      ));
      await Future.delayed(const Duration(milliseconds: 100));

      // Third failed attempt
      authBloc.add(const AuthLoginRequested(
        username: 'wrong',
        password: 'wrong',
      ));
      await Future.delayed(const Duration(milliseconds, 100));

      // Check that we have an error state with remaining attempts
      expect(authBloc.state, isA<AuthError>());
    });
  });

  group('AuthState', () {
    test('AuthAuthenticated should have correct properties', () {
      const state = AuthAuthenticated(
        userId: '1',
        username: 'admin',
        fullName: 'System Admin',
        role: 'ADMIN',
        permissions: ['MANAGE_MEMBERS', 'MANAGE_ACCOUNTING'],
        loginTime: DateTime(2024, 1, 15),
      );

      expect(state.userId, equals('1'));
      expect(state.username, equals('admin'));
      expect(state.fullName, equals('System Admin'));
      expect(state.role, equals('ADMIN'));
      expect(state.permissions, contains('MANAGE_MEMBERS'));
      expect(state.isAdmin, isTrue);
      expect(state.isTrainer, isFalse);
    });

    test('AuthAuthenticated isAdmin should return true for ADMIN role', () {
      const state = AuthAuthenticated(
        userId: '1',
        username: 'admin',
        fullName: 'Admin',
        role: 'ADMIN',
        permissions: [],
        loginTime: DateTime(2024, 1, 15),
      );
      expect(state.isAdmin, isTrue);
    });

    test('AuthAuthenticated isTrainer should return true for TRAINER role', () {
      const state = AuthAuthenticated(
        userId: '2',
        username: 'trainer',
        fullName: 'Trainer',
        role: 'TRAINER',
        permissions: [],
        loginTime: DateTime(2024, 1, 15),
      );
      expect(state.isTrainer, isTrue);
    });

    test('AuthAuthenticated hasPermission should check permissions', () {
      const state = AuthAuthenticated(
        userId: '1',
        username: 'admin',
        fullName: 'Admin',
        role: 'ADMIN',
        permissions: ['MANAGE_MEMBERS', 'VIEW_REPORTS'],
        loginTime: DateTime(2024, 1, 15),
      );
      expect(state.hasPermission('MANAGE_MEMBERS'), isTrue);
      expect(state.hasPermission('DELETE_ALL'), isFalse);
    });

    test('AuthError isLockedOut should check cooldown', () {
      final futureCooldown = DateTime.now().add(const Duration(minutes: 5));
      final pastCooldown = DateTime.now().subtract(const Duration(minutes: 5));

      final stateFuture = AuthError(
        message: 'Locked',
        cooldownEnd: futureCooldown,
      );

      final statePast = AuthError(
        message: 'Locked',
        cooldownEnd: pastCooldown,
      );

      expect(stateFuture.isLockedOut, isTrue);
      expect(statePast.isLockedOut, isFalse);
    });
  });

  group('AuthEvent', () {
    test('AuthLoginRequested should have correct properties', () {
      const event = AuthLoginRequested(
        username: 'admin',
        password: 'password123',
      );

      expect(event.username, equals('admin'));
      expect(event.password, equals('password123'));
    });

    test('AuthChangePasswordRequested should have correct properties', () {
      const event = AuthChangePasswordRequested(
        currentPassword: 'oldPass',
        newPassword: 'newPass',
      );

      expect(event.currentPassword, equals('oldPass'));
      expect(event.newPassword, equals('newPass'));
    });

    test('AuthFirstTimeSetupRequested should have correct properties', () {
      const event = AuthFirstTimeSetupRequested(
        adminUsername: 'admin',
        adminPassword: 'admin123',
        gymName: 'Test Gym',
      );

      expect(event.adminUsername, equals('admin'));
      expect(event.adminPassword, equals('admin123'));
      expect(event.gymName, equals('Test Gym'));
    });
  });
}