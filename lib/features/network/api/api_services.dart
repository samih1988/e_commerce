import 'package:dio/dio.dart';

import 'package:e_commerce_app/features/network/api/api_constant.dart';
import 'package:e_commerce_app/features/network/api/api_endpoints.dart';
import 'package:e_commerce_app/features/network/models/response/auth/auth_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../models/request/login/login_request.dart';
import '../models/request/register/register_request.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @POST(ApiEndPoints.loginApi)
  Future<AuthResponseDto> login(@Body() LoginRequest loginRequest);

  @POST(ApiEndPoints.registerApi)
  Future<AuthResponseDto> register(@Body() RegisterRequest registerRequest);

}

