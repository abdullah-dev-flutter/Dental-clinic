import 'package:supabase_flutter/supabase_flutter.dart';

class AppException implements Exception {
  final String message;
  final String type;

  AppException(this.message, this.type);


  

  factory AppException.auth(String message) => AppException(message, 'auth');
  factory AppException.duplicate(String message) => AppException(message, 'duplicate');
  factory AppException.rls(String message) => AppException(message, 'rls');
  factory AppException.database(String message) => AppException(message, 'database');
  factory AppException.storage(String message) => AppException(message, 'storage');
  factory AppException.unknown(String message) => AppException(message, 'unknown');

  @override
  String toString() => message;
}

Future<T> safeCall<T>(Future<T> Function() fn) async {
  try {
    return await fn();
  } on AuthException catch (e) {
    throw AppException.auth(e.message);
  } on PostgrestException catch (e) {
    if (e.code == '23505') throw AppException.duplicate('Already exists.');
    if (e.code == '42501') throw AppException.rls('Permission denied.');
    throw AppException.database(e.message);
  } on StorageException catch (e) {
    throw AppException.storage(e.message);
  } catch (e) {
    throw AppException.unknown(e.toString());
  }
}
