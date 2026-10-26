import 'package:e_commerce_app/core/errors/app_errors.dart';

sealed class ApiResult<T> {
  bool get hasData => this is SuccessApiResult<T>;
  bool get hasError => this is ErrorApiResult<T>;

  // Backwards compatibility for typo
  bool get haseData => hasData;
  bool get haseError => hasError;

  T? get getData => this is SuccessApiResult<T> ? (this as SuccessApiResult<T>).data : null;
  String? get getError => this is ErrorApiResult<T> ? (this as ErrorApiResult<T>).error.errorMessage : null;
}
class SuccessApiResult<T> extends ApiResult<T>{
  final T? data;
  SuccessApiResult({required this.data});
}

class ErrorApiResult<T> extends ApiResult<T>{
  final AppErrors error;
  ErrorApiResult({required this.error});
}

extension ApiResultExtension<T> on ApiResult<T> {
  ApiResult<R> map<R>(R? Function(T data) transform) {
    return switch (this) {
      SuccessApiResult(:final data) => SuccessApiResult<R>(
          data: data != null ? transform(data) : null,
        ),
      ErrorApiResult(:final error) => ErrorApiResult<R>(error: error),
    };
  }
}