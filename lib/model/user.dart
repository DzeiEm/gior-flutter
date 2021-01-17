import 'dart:io';

class User {
  final String userId;
  final String email;
  final String name;
  final String password;
  final String repassword;
  final int phone;
  final int role;
  final File profileImage;

  User(
      {this.userId,
      this.email,
      this.name,
      this.password,
      this.repassword,
      this.phone,
      this.role,
      this.profileImage});
}
