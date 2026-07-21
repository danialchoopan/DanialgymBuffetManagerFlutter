import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final BiometricHelper _instance = BiometricHelper._();
  factory BiometricHelper() => _instance;
  BiometricHelper._();

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  Future<bool> authenticateWithBiometrics({
    String localizedReason = 'Please authenticate to continue',
    bool useErrorDialogs = true,
    bool stickyAuth = true,
    bool biometricOnly = false,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: biometricOnly,
        ),
      );
    } on PlatformException {
      return false;
    }
  }

  Future<bool> authenticateWithFingerprint({
    String localizedReason = 'Please authenticate with your fingerprint',
  }) async {
    final biometrics = await getAvailableBiometrics();
    if (!biometrics.contains(BiometricType.fingerprint)) {
      return false;
    }
    return await authenticateWithBiometrics(
      localizedReason: localizedReason,
      biometricOnly: true,
    );
  }

  Future<bool> authenticateWithFaceId({
    String localizedReason = 'Please authenticate with Face ID',
  }) async {
    final biometrics = await getAvailableBiometrics();
    if (!biometrics.contains(BiometricType.face)) {
      return false;
    }
    return await authenticateWithBiometrics(
      localizedReason: localizedReason,
      biometricOnly: true,
    );
  }

  Future<void> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } on PlatformException {
      // Ignore
    }
  }
}