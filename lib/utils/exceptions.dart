class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException(this.message);

  @override
  String toString() => message;
}

class DatabaseException implements Exception {
  final String message;
  const DatabaseException(this.message);

  @override
  String toString() => message;
} 