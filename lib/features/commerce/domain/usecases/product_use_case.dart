import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';
import 'package:e_commerce_app/features/commerce/domain/repository/home_repository.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class ProductUseCase {
  HomeRepository homeRepository;
  ProductUseCase({required this.homeRepository});

  Future<ApiResult<List<Product>>> call(){
    return homeRepository.getAllProducts();
  }
}