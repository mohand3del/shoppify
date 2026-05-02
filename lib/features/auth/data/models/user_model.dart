class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final String id;
  final String refreshToken;
  final String expiresAtUtc;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
    required this.id, required this.refreshToken, required this.expiresAtUtc,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final firstName = (json['firstName'] ?? json['first_name'] ?? '')
        .toString();
    final lastName = (json['lastName'] ?? json['last_name'] ?? '').toString();
    final fullName = '$firstName $lastName'.trim();

    return UserModel(
      id: (json['id'] ?? json['userId'] ?? '').toString(),
      firstName: (json['firstName'] ?? json['first_name'] ?? '').toString(),
      lastName: (json['lastName'] ?? json['last_name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      token:
          (json['token'] ?? json['accessToken'] ?? json['access_token'] ?? '')
              .toString(),
      refreshToken: (json['refreshToken'] ?? json['refresh_token'] ?? '').toString(),
      expiresAtUtc: (json['expiresAtUtc'] ?? json['expires_at_utc'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'token': token,
      'id': id,
      'refreshToken': refreshToken,
      'expiresAtUtc': expiresAtUtc,
    };
  }
}
