import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/core/chach/shared_preferencse_utils.dart';
import 'package:e_commerce_app/core/errors/app_errors.dart';
import 'package:e_commerce_app/core/extension/network_connectivity.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/models/request/login/login_request.dart';
import 'package:e_commerce_app/features/network/models/request/register/register_request.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/auth/auth_response.dart';
import '../mappers/auth_mapper.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  Connectivity connectivity;
  SharedPreferencseUtils preferencseUtils;
  AuthRepositoryImpl(
      {required this.authRemoteDataSource,required this.preferencseUtils, required this.connectivity});

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest loginRequest) async {
    if (await connectivity.isConnected()) {
      final result = await authRemoteDataSource.login(loginRequest);
      if (result.haseData) {
        final token = result.getData?.token;
        if (token != null && token.isNotEmpty) {
          await preferencseUtils.saveData(key: 'token', value: token);
          final user = result.getData?.user;
          if (user != null) {
            await preferencseUtils.saveData(key: 'userName', value: user.name);
            await preferencseUtils.saveData(key: 'userEmail', value: user.email);
          }
        } else {
          return ErrorApiResult(
            error: ServerError(
                message: 'Failed to retrieve authentication token'),
          );
        }
      }
      return result.map((dto) => dto.toEntity());
    } else {
      return ErrorApiResult(error: NetworkError());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> register(
      RegisterRequest registerRequest) async {
    if (await connectivity.isConnected()) {
      final result = await authRemoteDataSource.register(registerRequest);
      if (result.haseData) {
        final token = result.getData?.token;
        if (token != null && token.isNotEmpty) {
          await preferencseUtils.saveData(key: 'token', value: token);
          final user = result.getData?.user;
          if (user != null) {
            await preferencseUtils.saveData(key: 'userName', value: user.name);
            await preferencseUtils.saveData(key: 'userEmail', value: user.email);
          }
          if (registerRequest.phone != null && registerRequest.phone!.isNotEmpty) {
            await preferencseUtils.saveData(key: 'userPhone', value: registerRequest.phone);
          }
        } else {
          return ErrorApiResult(
            error: ServerError(
                message: 'Failed to retrieve authentication token'),
          );
        }
      }
      return result.map((dto) => dto.toEntity());
    } else {
      return ErrorApiResult(error: NetworkError());
    }
  }
}
