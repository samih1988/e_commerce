import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/app_errors.dart';
import 'package:e_commerce_app/features/commerce/data/data_sources/remote/home_remote_data_source.dart';
import 'package:e_commerce_app/features/network/api/api_result.dart';
import 'package:e_commerce_app/features/network/api/api_services.dart';
import 'package:e_commerce_app/features/network/handle_dio_error.dart';
import 'package:e_commerce_app/features/network/models/response/categories/category_response_dto.dart';
import 'package:e_commerce_app/features/network/models/response/product/product_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiServices apiServices;
  HomeRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<ApiResult<CategoryResponseDto>> getAllBrands() async {
    try {
      var apiResult = await apiServices.getAllBrands();
      return SuccessApiResult(data: apiResult);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return ErrorApiResult(error: UnknownError());
    }
  }

  @override
  Future<ApiResult<CategoryResponseDto>> getAllCategory() async{
  try{
    var apiResult= await apiServices.getAllCategories();
    return SuccessApiResult(data: apiResult);
  }on DioException catch(e){
    return handleDioError(e);
  }catch(e){
    return ErrorApiResult(error: UnknownError());
  }
  }

  @override
  Future<ApiResult<ProductResponseDto>> getAllProducts() async{
    try{
      var proResult= await apiServices.getAllProducts();
      return SuccessApiResult(data: proResult);
    }on DioException catch(e){
      return handleDioError(e);
    }catch(e){
      return ErrorApiResult(error: ServerError());
    }
  }
}
