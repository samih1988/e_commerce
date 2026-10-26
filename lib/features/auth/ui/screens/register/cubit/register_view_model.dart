import 'package:e_commerce_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';
import 'package:e_commerce_app/features/network/models/request/register/register_request.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth/auth_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<ResourceState<AuthResponse>> {
  final RegisterUseCase registerUseCase;
  RegisterViewModel({required this.registerUseCase})
      : super(ResourceState.initial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    emit(ResourceState.loading());
    try {
      RegisterRequest registerRequest = RegisterRequest(
          password: password,
          email: email,
          name: name,
          phone: phone,
          rePassword: rePassword);
      var apiResult = await registerUseCase(registerRequest);
      if (apiResult.haseData) {
        emit(ResourceState.success(data: apiResult.getData));
      } else {
        emit(ResourceState.error(errorMessage: apiResult.getError));
      }
    } catch (e) {
      emit(ResourceState.error(errorMessage: e.toString()));
    }
  }
}