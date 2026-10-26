import 'package:e_commerce_app/features/auth/domain/entities/auth/auth_response.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth/user.dart';
import 'package:e_commerce_app/features/network/models/response/auth/auth_response_dto.dart';
import 'package:e_commerce_app/features/network/models/response/auth/user_dto.dart';

extension UserDtoMapper on UserDto {
  User toEntity() {
    return User(
      name: name,
      email: email,
    );
  }
}

extension AuthResponseDtoMapper on AuthResponseDto {
  AuthResponse toEntity() {
    return AuthResponse(
      message: message,
      token: token,
      user: user?.toEntity(),
    );
  }
}
