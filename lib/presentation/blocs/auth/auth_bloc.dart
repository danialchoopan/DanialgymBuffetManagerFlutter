import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// AUTH STATES
// ============================================================

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  final String? message;

  const AuthLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthAuthenticated extends AuthState {
  final String userId;
  final String username;
  final String fullName;
  final String role;
  final List<String> permissions;
  final DateTime loginTime;

  const AuthAuthenticated({
    required this.userId,
    required this.username,
    required this.fullName,
    required this.role,
    required this.permissions,
    required this.loginTime,
  });

  bool get isAdmin => role == 'ADMIN';
  bool get isTrainer => role == 'TRAINER';
  bool get isAccountant => role == 'ACCOUNTANT';
  bool get isReceptionist => role == 'RECEPTIONIST';

  bool hasPermission(String permission) => permissions.contains(permission);

  @override
  List<Object?> get props => [userId, username, fullName, role, permissions, loginTime];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthLocked extends AuthState {
  final DateTime lockedAt;

  const AuthLocked({required this.lockedAt});

  @override
  List<Object?> get props => [lockedAt];
}

class AuthBiometricRequired extends AuthState {
  final String username;

  const AuthBiometricRequired({required this.username});

  @override
  List<Object?> get props => [username];
}

class AuthError extends AuthState {
  final String message;
  final String? code;
  final int? remainingAttempts;
  final DateTime? cooldownEnd;

  const AuthError({
    required this.message,
    this.code,
    this.remainingAttempts,
    this.cooldownEnd,
  });

  bool get isLockedOut => cooldownEnd != null && cooldownEnd!.isAfter(DateTime.now());

  @override
  List<Object?> get props => [message, code, remainingAttempts, cooldownEnd];
}

class AuthSessionExpired extends AuthState {
  const AuthSessionExpired();
}

class AuthFirstTimeSetup extends AuthState {
  const AuthFirstTimeSetup();
}

// ============================================================
// AUTH EVENTS
// ============================================================

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class AuthBiometricLoginRequested extends AuthEvent {
  const AuthBiometricLoginRequested();
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}

class AuthLockScreenRequested extends AuthEvent {
  const AuthLockScreenRequested();
}

class AuthUnlockScreenRequested extends AuthEvent {
  final String? password;

  const AuthUnlockScreenRequested({this.password});

  @override
  List<Object?> get props => [password];
}

class AuthSessionTimeoutRequested extends AuthEvent {
  const AuthSessionTimeoutRequested();
}

class AuthChangePasswordRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  const AuthChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class AuthFirstTimeSetupRequested extends AuthEvent {
  final String adminUsername;
  final String adminPassword;
  final String gymName;

  const AuthFirstTimeSetupRequested({
    required this.adminUsername,
    required this.adminPassword,
    required this.gymName,
  });

  @override
  List<Object?> get props => [adminUsername, adminPassword, gymName];
}

class AuthActivityDetected extends AuthEvent {
  const AuthActivityDetected();
}

// ============================================================
// AUTH BLOC
// ============================================================

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Dependencies would be injected here
  // final AuthRepository _authRepository;
  // final SecureStorageService _secureStorage;
  // final BiometricService _biometricService;

  int _failedAttempts = 0;
  DateTime? _cooldownEnd;
  DateTime? _lastActivity;
  bool _isFirstTimeSetup = false;

  AuthBloc() : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthBiometricLoginRequested>(_onBiometricLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
    on<AuthLockScreenRequested>(_onLockScreenRequested);
    on<AuthUnlockScreenRequested>(_onUnlockScreenRequested);
    on<AuthSessionTimeoutRequested>(_onSessionTimeoutRequested);
    on<AuthChangePasswordRequested>(_onChangePasswordRequested);
    on<AuthFirstTimeSetupRequested>(_onFirstTimeSetupRequested);
    on<AuthActivityDetected>(_onActivityDetected);
  }

  // ============================================================
  // EVENT HANDLERS
  // ============================================================

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'در حال ورود...'));

    try {
      // Check if in cooldown period
      if (_cooldownEnd != null && DateTime.now().isBefore(_cooldownEnd!)) {
        final remaining = _cooldownEnd!.difference(DateTime.now()).inSeconds;
        emit(AuthError(
          message: '账户 قفل شده است. لطفاً $remaining ثانیه صبر کنید.',
          cooldownEnd: _cooldownEnd,
        ));
        return;
      }

      // Validate credentials (simplified - would use actual repository)
      final isValid = await _validateCredentials(event.username, event.password);

      if (isValid) {
        _failedAttempts = 0;
        _cooldownEnd = null;
        _lastActivity = DateTime.now();

        // Create session
        final session = await _createSession(event.username);

        emit(AuthAuthenticated(
          userId: session['userId'],
          username: session['username'],
          fullName: session['fullName'],
          role: session['role'],
          permissions: session['permissions'],
          loginTime: DateTime.now(),
        ));
      } else {
        _failedAttempts++;

        if (_failedAttempts >= 5) {
          _cooldownEnd = DateTime.now().add(const Duration(minutes: 5));
          emit(AuthError(
            message: 'تعداد تلاش‌های ناموفق بیش از حد مجاز است. حساب شما به مدت 5 دقیقه قفل شد.',
            code: 'MAX_ATTEMPTS_EXCEEDED',
            remainingAttempts: 0,
            cooldownEnd: _cooldownEnd,
          ));
        } else {
          emit(AuthError(
            message: 'نام کاربری یا رمز عبور اشتباه است.',
            code: 'INVALID_CREDENTIALS',
            remainingAttempts: 5 - _failedAttempts,
          ));
        }
      }
    } catch (e) {
      emit(AuthError(
        message: 'خطا در ورود. لطفاً دوباره تلاش کنید.',
        code: 'LOGIN_ERROR',
      ));
    }
  }

  Future<void> _onBiometricLoginRequested(
    AuthBiometricLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'در حال تشخیص هویت...'));

    try {
      // Check biometric availability
      final isAvailable = await _checkBiometricAvailability();

      if (!isAvailable) {
        emit(const AuthError(
          message: 'تشخیص اثر انگشت در دسترس نیست.',
          code: 'BIOMETRIC_NOT_AVAILABLE',
        ));
        return;
      }

      // Authenticate with biometric
      final isAuthenticated = await _authenticateWithBiometric();

      if (isAuthenticated) {
        _lastActivity = DateTime.now();

        // Get user from stored credentials
        final session = await _getStoredSession();

        if (session != null) {
          emit(AuthAuthenticated(
            userId: session['userId'],
            username: session['username'],
            fullName: session['fullName'],
            role: session['role'],
            permissions: session['permissions'],
            loginTime: DateTime.now(),
          ));
        } else {
          emit(const AuthError(
            message: 'لطفاً ابتدا با رمز عبور وارد شوید.',
            code: 'NO_STORED_CREDENTIALS',
          ));
        }
      } else {
        emit(const AuthError(
          message: 'تشخیص هویت ناموفق بود.',
          code: 'BIOMETRIC_FAILED',
        ));
      }
    } catch (e) {
      emit(AuthError(
        message: 'خطا در تشخیص هویت.',
        code: 'BIOMETRIC_ERROR',
      ));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'در حال خروج...'));

    try {
      // Clear session
      await _clearSession();

      _failedAttempts = 0;
      _cooldownEnd = null;
      _lastActivity = null;

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(
        message: 'خطا در خروج.',
        code: 'LOGOUT_ERROR',
      ));
    }
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Check if first time setup needed
      if (_isFirstTimeSetup) {
        emit(const AuthFirstTimeSetup());
        return;
      }

      // Check stored session
      final session = await _getStoredSession();

      if (session != null) {
        // Check if session expired
        final loginTime = DateTime.parse(session['loginTime']);
        if (DateTime.now().difference(loginTime).inHours > 8) {
          emit(const AuthSessionExpired());
          return;
        }

        emit(AuthAuthenticated(
          userId: session['userId'],
          username: session['username'],
          fullName: session['fullName'],
          role: session['role'],
          permissions: session['permissions'],
          loginTime: loginTime,
        ));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLockScreenRequested(
    AuthLockScreenRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLocked(lockedAt: DateTime.now()));
  }

  Future<void> _onUnlockScreenRequested(
    AuthUnlockScreenRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (event.password != null) {
      // Validate password
      final isValid = await _validatePassword(event.password!);

      if (isValid) {
        _lastActivity = DateTime.now();
        final session = await _getStoredSession();

        if (session != null) {
          emit(AuthAuthenticated(
            userId: session['userId'],
            username: session['username'],
            fullName: session['fullName'],
            role: session['role'],
            permissions: session['permissions'],
            loginTime: DateTime.parse(session['loginTime']),
          ));
          return;
        }
      }

      emit(const AuthError(
        message: 'رمز عبور اشتباه است.',
        code: 'INVALID_PASSWORD',
      ));
    } else {
      // Try biometric unlock
      final isAuthenticated = await _authenticateWithBiometric();

      if (isAuthenticated) {
        _lastActivity = DateTime.now();
        final session = await _getStoredSession();

        if (session != null) {
          emit(AuthAuthenticated(
            userId: session['userId'],
            username: session['username'],
            fullName: session['fullName'],
            role: session['role'],
            permissions: session['permissions'],
            loginTime: DateTime.parse(session['loginTime']),
          ));
          return;
        }
      }

      emit(const AuthError(
        message: 'تشخیص هویت ناموفق بود.',
        code: 'BIOMETRIC_UNLOCK_FAILED',
      ));
    }
  }

  Future<void> _onSessionTimeoutRequested(
    AuthSessionTimeoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthSessionExpired());
  }

  Future<void> _onChangePasswordRequested(
    AuthChangePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'در حال تغییر رمز عبور...'));

    try {
      // Validate current password
      final isValid = await _validatePassword(event.currentPassword);

      if (!isValid) {
        emit(const AuthError(
          message: 'رمز عبور فعلی اشتباه است.',
          code: 'INVALID_CURRENT_PASSWORD',
        ));
        return;
      }

      // Validate new password strength
      if (event.newPassword.length < 8) {
        emit(const AuthError(
          message: 'رمز عبور جدید باید حداقل 8 کاراکتر باشد.',
          code: 'WEAK_PASSWORD',
        ));
        return;
      }

      // Update password
      await _updatePassword(event.newPassword);

      emit(const AuthOperationSuccess(message: 'رمز عبور با موفقیت تغییر کرد.'));
    } catch (e) {
      emit(AuthError(
        message: 'خطا در تغییر رمز عبور.',
        code: 'CHANGE_PASSWORD_ERROR',
      ));
    }
  }

  Future<void> _onFirstTimeSetupRequested(
    AuthFirstTimeSetupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'در حال راه‌اندازی اولیه...'));

    try {
      // Create admin user
      await _createAdminUser(
        event.adminUsername,
        event.adminPassword,
        event.gymName,
      );

      _isFirstTimeSetup = false;

      emit(const AuthOperationSuccess(message: 'راه‌اندازی با موفقیت انجام شد.'));
    } catch (e) {
      emit(AuthError(
        message: 'خطا در راه‌اندازی اولیه.',
        code: 'SETUP_ERROR',
      ));
    }
  }

  Future<void> _onActivityDetected(
    AuthActivityDetected event,
    Emitter<AuthState> emit,
  ) async {
    _lastActivity = DateTime.now();
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  Future<bool> _validateCredentials(String username, String password) async {
    // Simplified validation - would use actual repository
    await Future.delayed(const Duration(milliseconds: 500));
    return username.isNotEmpty && password.isNotEmpty;
  }

  Future<Map<String, dynamic>> _createSession(String username) async {
    // Simplified - would use actual repository
    return {
      'userId': '1',
      'username': username,
      'fullName': 'System Admin',
      'role': 'ADMIN',
      'permissions': ['MANAGE_MEMBERS', 'MANAGE_TRAINERS', 'MANAGE_ACCOUNTING'],
      'loginTime': DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>?> _getStoredSession() async {
    // Simplified - would use secure storage
    return null;
  }

  Future<void> _clearSession() async {
    // Simplified - would clear secure storage
  }

  Future<bool> _checkBiometricAvailability() async {
    // Simplified - would check actual biometric availability
    return true;
  }

  Future<bool> _authenticateWithBiometric() async {
    // Simplified - would use actual biometric service
    return false;
  }

  Future<bool> _validatePassword(String password) async {
    // Simplified - would validate against stored hash
    return password.isNotEmpty;
  }

  Future<void> _updatePassword(String newPassword) async {
    // Simplified - would update password hash
  }

  Future<void> _createAdminUser(String username, String password, String gymName) async {
    // Simplified - would create admin user in database
  }
}

// Operation Success State
class AuthOperationSuccess extends AuthState {
  final String message;

  const AuthOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}