import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/models/response/categories/category_response_dto.dart';
import 'package:e_commerce_app/features/network/models/response/product/product_response_dto.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<CategoryResponseDto>> getAllCategory();
  Future<ApiResult<CategoryResponseDto>> getAllBrands();
  Future<ApiResult<ProductResponseDto>> getAllProducts();

}
