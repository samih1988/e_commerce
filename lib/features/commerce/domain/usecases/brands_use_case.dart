import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/commerce/domain/repository/home_repository.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class BrandsUseCase {
  HomeRepository homeRepository;
  BrandsUseCase({required this.homeRepository});
 Future<ApiResult<List<Category>>> call(){
    return homeRepository.getAllBrands();
  }
}