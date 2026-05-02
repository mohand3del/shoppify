

class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final String refreshToken;
  final String expiresAtUtc;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token, required this.refreshToken, 
    required this.expiresAtUtc,
  });
}