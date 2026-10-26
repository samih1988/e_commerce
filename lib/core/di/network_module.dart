import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/network/api/api_constant.dart';
import 'package:e_commerce_app/features/network/api/api_services.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule{
  @LazySingleton()
  BaseOptions provideBaseOptions(){
    return BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
  }

  @LazySingleton()
  PrettyDioLogger providePrettyDioLogger(){
    return PrettyDioLogger(
        request: true ,
        responseBody: true,
        requestBody: true,
        responseHeader: true ,
        requestHeader: true,
        error: true
    );
  }

  @LazySingleton()
  Dio provideDio(BaseOptions baseOptions,PrettyDioLogger prettyDioLogger){
    var dio =  Dio(baseOptions);
    //todo: dio interceptors
    dio.interceptors.add(prettyDioLogger);
    return dio ;
  }
  @LazySingleton()
  ApiServices provideWebServices(Dio dio) {
    return ApiServices(dio);
  }
  @LazySingleton()
Connectivity get provideConnectivity=>Connectivity();

}