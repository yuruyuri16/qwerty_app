import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage/storage.dart';

/// {@template secure_storage}
/// A Secure Storage client which implements the base [Storage] interface.
/// [SecureStorage] uses `FlutterSecureStorage` internally.
/// {@endtemplate}
class SecureStorage implements Storage {
  /// {@macro secure_storage}
  const SecureStorage({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> read({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }
}
