import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/core/errors/app_errors.dart';
import 'package:e_commerce_app/core/extension/network_connectivity.dart';
import 'package:e_commerce_app/features/commerce/data/data_sources/remote/home_remote_data_source.dart';
import 'package:e_commerce_app/features/commerce/data/mappers/category_mapper.dart';
import 'package:e_commerce_app/features/commerce/data/mappers/product_mapper.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';
import 'package:e_commerce_app/features/commerce/domain/repository/home_repository.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl  implements HomeRepository{
  HomeRemoteDataSource homeRemoteDataSource;
  Connectivity connectivity;
  HomeRepositoryImpl({required this.connectivity,required this.homeRemoteDataSource});

  @override
  Future<ApiResult<List<Category>>> getAllBrands() async {
    if (await connectivity.isConnected()) {
      var apiResult = await homeRemoteDataSource.getAllBrands();

      if(apiResult.haseData && apiResult.getData?.data !=null){
        return SuccessApiResult(data: apiResult.getData?.data!.toCategoryList());
      }else
      {
        return ErrorApiResult(error: ServerError(message: apiResult.getError!));
      }
    } else {
      return ErrorApiResult(error: NetworkError());
    }
  }

  @override
  Future<ApiResult<List<Category>>> getAllCategories() async {
    if (await connectivity.isConnected()) {
      var apiResult = await homeRemoteDataSource.getAllCategory();
      if(apiResult.haseData && apiResult.getData?.data !=null){
        return SuccessApiResult(data: apiResult.getData?.data!.toCategoryList());
      }else
      {
        return ErrorApiResult(error: ServerError(message: apiResult.getError!));
      }
    } else {
      return ErrorApiResult(error: NetworkError());
    }
  }

  @override
  Future<ApiResult<List<Product>>> getAllProducts() async{
  if( await connectivity.isConnected()){
    var productResult= await homeRemoteDataSource.getAllProducts();
    if(productResult.haseData && productResult.getData?.data !=null){
      return SuccessApiResult(data: productResult.getData?.data!.toProductList());
    }else
    {
      return ErrorApiResult(error: ServerError(message: productResult.getError!));
    }
  }else{
    return ErrorApiResult(error: NetworkError());
  }

  }

}