import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/models/request/login/login_request.dart';
import 'package:e_commerce_app/features/network/models/request/register/register_request.dart';
import 'package:e_commerce_app/features/network/models/response/auth/auth_response_dto.dart';

abstract class AuthRemoteDataSource {
 Future<ApiResult<AuthResponseDto>> login(LoginRequest loginRequest);
 Future<ApiResult<AuthResponseDto>> register(RegisterRequest registerRequest);
}