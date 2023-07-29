import 'dart:convert';

class User {
  String token;
  String id;
  String userName;
  String name;
  String email;
  User({
    required this.token,
    required this.id,
    required this.userName,
    required this.name,
    required this.email,
  });

  @override
  String toString() {
    return 'User(token: $token, id: $id, userName: $userName, name: $name, email: $email)';
  }

  User copyWith({
    String? token,
    String? id,
    String? userName,
    String? name,
    String? email,
  }) {
    return User(
      token: token ?? this.token,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'user': {
        'id': id,
        'userName': userName,
        'name': name,
        'email': email,
      }
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      id: map['user']['id'] as String,
      userName: map['user']['userName'] as String,
      name: map['user']['name'] as String,
      email: map['user']['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
