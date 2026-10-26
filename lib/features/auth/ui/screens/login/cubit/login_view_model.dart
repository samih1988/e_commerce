import 'package:e_commerce_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';
import 'package:e_commerce_app/features/network/models/request/login/login_request.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth/auth_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<ResourceState<AuthResponse>> {
  final LoginUseCase loginUseCase;
  LoginViewModel({required this.loginUseCase}) : super(ResourceState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(ResourceState.loading());
    try {
      LoginRequest loginRequest =
          LoginRequest(email: email, password: password);
      var apiResult = await loginUseCase(loginRequest);
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
