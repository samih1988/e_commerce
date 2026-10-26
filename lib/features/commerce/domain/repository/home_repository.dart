import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';

abstract class  HomeRepository{

  Future<ApiResult<List<Category>>>getAllCategories();

  Future<ApiResult<List<Category>>>getAllBrands();
  Future<ApiResult<List<Product>>>getAllProducts();

}