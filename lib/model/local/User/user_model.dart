class LocalUserModel {
  final int? id;
  final String username;
  final String joined;
  final String email;
  final String password;
  final String profilePicture;

  LocalUserModel({
    this.id,
    required this.username,
    required this.joined,
    required this.email,
    required this.password,
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'nickname': joined,
      'email': email,
      'password': password,
      'profile_picture': profilePicture,
    };
  }

  factory LocalUserModel.fromMap(Map<String, dynamic> map) {
    return LocalUserModel(
      id: map['id'],
      username: map['username'],
      joined: map['nickname'],
      email: map['email'],
      password: map['password'],
      profilePicture: map['profile_picture'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, nickname: $joined, email: $email, password: $password, profilePicture: $profilePicture}';
  }
}
