import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/app_errors.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/api/api_services.dart';
import 'package:e_commerce_app/features/network/handle_dio_error.dart';
import 'package:e_commerce_app/features/network/models/request/login/login_request.dart';
import 'package:e_commerce_app/features/network/models/request/register/register_request.dart';
import 'package:e_commerce_app/features/network/models/response/auth/auth_response_dto.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:AuthRemoteDataSource )
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  ApiServices apiServices;
  AuthRemoteDataSourceImpl({required this.apiServices});
  @override
  Future<ApiResult<AuthResponseDto>> login(LoginRequest loginRequest) async {
    try {
      var authResponse = await apiServices.login(loginRequest);
      return SuccessApiResult(data: authResponse);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return ErrorApiResult(error: UnknownError());
    }
  }

  @override
  Future<ApiResult<AuthResponseDto>> register(
      RegisterRequest registerRequest) async {
    try {
      var authResponse = await apiServices.register(registerRequest);
      return SuccessApiResult(data: authResponse);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return ErrorApiResult(error: UnknownError());
    }
  }

}