import 'package:e_commerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/models/request/login/login_request.dart';
import 'package:injectable/injectable.dart';
import '../entities/auth/auth_response.dart';

@LazySingleton()
class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<ApiResult<AuthResponse>> call(LoginRequest loginRequest) {
    return authRepository.login(loginRequest);
  }
}
