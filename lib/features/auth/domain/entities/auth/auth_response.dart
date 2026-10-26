import 'package:e_commerce_app/features/auth/domain/entities/auth/user.dart';

class AuthResponse {
  final String? message;
  final User? user;
  final String? token;

  AuthResponse({
    this.message,
    this.user,
    this.token,
  });

}




