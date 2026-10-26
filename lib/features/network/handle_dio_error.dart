import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/app_errors.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';

ApiResult<T> handleDioError<T>(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return ErrorApiResult(error: NetworkError());

    case DioExceptionType.badResponse:
      return ErrorApiResult(
        error: ServerError(message: _extractErrorMessage(e.response)),
      );

    case DioExceptionType.cancel:
      return ErrorApiResult(error: UnknownError(message: "Request was cancelled"));

    default:
      return ErrorApiResult(error: UnknownError());
  }
}

String _extractErrorMessage(Response? response) {
  if (response == null) return "No response from server";

  final data = response.data;

  if (data is Map) {
    // 1. Direct message field
    if (data['message'] != null && data['message'] is String && (data['message'] as String).trim().isNotEmpty) {
      return data['message'].toString();
    }

    // 2. errors field as a List
    if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
      final firstError = (data['errors'] as List).first;
      if (firstError is Map && firstError['msg'] != null) {
        return firstError['msg'].toString();
      }
      if (firstError is String) {
        return firstError;
      }
    }

    // 3. errors field as a Map
    if (data['errors'] is Map) {
      final errorsMap = data['errors'] as Map;
      if (errorsMap['msg'] != null) {
        return errorsMap['msg'].toString();
      }
      final firstValue = errorsMap.values.isNotEmpty ? errorsMap.values.first : null;
      if (firstValue is List && firstValue.isNotEmpty) {
        return firstValue.first.toString();
      }
      if (firstValue is String) {
        return firstValue;
      }
    }

    // 4. statusMsg field
    if (data['statusMsg'] != null && data['statusMsg'] is String && (data['statusMsg'] as String).trim().isNotEmpty) {
      return data['statusMsg'].toString();
    }
  }

  // Fallback by HTTP status code
  final statusCode = response.statusCode;
  if (statusCode == 401) return "Incorrect email or password, or session expired.";
  if (statusCode == 403) return "You do not have permission to perform this action.";
  if (statusCode == 404) return "Resource not found.";
  if (statusCode != null && statusCode >= 500) return "Internal server error. Please try again later.";

  return response.statusMessage ?? "Something went wrong. Please try again.";
}