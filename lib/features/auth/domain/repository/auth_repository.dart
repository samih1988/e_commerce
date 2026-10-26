import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/models/request/login/login_request.dart';
import 'package:e_commerce_app/features/network/models/request/register/register_request.dart';
import '../entities/auth/auth_response.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthResponse>> login(LoginRequest loginRequest);
  Future<ApiResult<AuthResponse>> register(RegisterRequest registerRequest);
}