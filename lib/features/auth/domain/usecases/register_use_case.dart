import 'package:e_commerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/models/request/register/register_request.dart';
import 'package:injectable/injectable.dart';
import '../entities/auth/auth_response.dart';

@LazySingleton()
class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});

  Future<ApiResult<AuthResponse>> call(RegisterRequest registerRequest) {
    return authRepository.register(registerRequest);
  }
}
