// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart'
    as _i299;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/register_use_case.dart' as _i97;
import '../../features/auth/ui/screens/login/cubit/login_view_model.dart'
    as _i89;
import '../../features/auth/ui/screens/register/cubit/register_view_model.dart'
    as _i617;
import '../../features/commerce/data/data_sources/remote/home_remote_data_source.dart'
    as _i622;
import '../../features/commerce/data/data_sources/remote/home_remote_data_source_impl.dart'
    as _i850;
import '../../features/commerce/data/repository/home_repository_impl.dart'
    as _i22;
import '../../features/commerce/domain/entities/product/product.dart' as _i710;
import '../../features/commerce/domain/repository/home_repository.dart'
    as _i457;
import '../../features/commerce/domain/usecases/brands_use_case.dart' as _i289;
import '../../features/commerce/domain/usecases/category_use_case.dart'
    as _i982;
import '../../features/commerce/domain/usecases/product_use_case.dart'
    as _i1033;
import '../../features/commerce/ui/home/cubit/home_screen_view_model.dart'
    as _i146;
import '../../features/commerce/ui/home/tabs/home_tab/cubit/home_tab_view_model.dart'
    as _i939;
import '../../features/commerce/ui/home/tabs/products_tab/cubit/product_state.dart'
    as _i278;
import '../../features/common/resource_state.dart' as _i523;
import '../../features/network/api/api_services.dart' as _i392;
import '../chach/shared_preferencse_utils.dart' as _i1021;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.factory<_i146.HomeScreenViewModel>(() => _i146.HomeScreenViewModel());
    gh.lazySingleton<_i1021.SharedPreferencseUtils>(
        () => _i1021.SharedPreferencseUtils());
    gh.lazySingleton<_i895.Connectivity>(
        () => networkModule.provideConnectivity);
    gh.lazySingleton<_i361.BaseOptions>(
        () => networkModule.provideBaseOptions());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => networkModule.providePrettyDioLogger());
    gh.lazySingleton<_i361.Dio>(() => networkModule.provideDio(
          gh<_i361.BaseOptions>(),
          gh<_i528.PrettyDioLogger>(),
        ));
    gh.lazySingleton<_i278.ProductState>(() => _i278.ProductState(
        productState: gh<_i523.ResourceState<List<_i710.Product>>>()));
    gh.lazySingleton<_i392.ApiServices>(
        () => networkModule.provideWebServices(gh<_i361.Dio>()));
    gh.factory<_i622.HomeRemoteDataSource>(() =>
        _i850.HomeRemoteDataSourceImpl(apiServices: gh<_i392.ApiServices>()));
    gh.factory<_i432.AuthRemoteDataSource>(() =>
        _i299.AuthRemoteDataSourceImpl(apiServices: gh<_i392.ApiServices>()));
    gh.factory<_i457.HomeRepository>(() => _i22.HomeRepositoryImpl(
          connectivity: gh<_i895.Connectivity>(),
          homeRemoteDataSource: gh<_i622.HomeRemoteDataSource>(),
        ));
    gh.factory<_i961.AuthRepository>(() => _i409.AuthRepositoryImpl(
          authRemoteDataSource: gh<_i432.AuthRemoteDataSource>(),
          preferencseUtils: gh<_i1021.SharedPreferencseUtils>(),
          connectivity: gh<_i895.Connectivity>(),
        ));
    gh.lazySingleton<_i289.BrandsUseCase>(
        () => _i289.BrandsUseCase(homeRepository: gh<_i457.HomeRepository>()));
    gh.lazySingleton<_i982.CategoryUseCase>(() =>
        _i982.CategoryUseCase(homeRepository: gh<_i457.HomeRepository>()));
    gh.lazySingleton<_i1033.ProductUseCase>(() =>
        _i1033.ProductUseCase(homeRepository: gh<_i457.HomeRepository>()));
    gh.factory<_i939.HomeTabViewModel>(() => _i939.HomeTabViewModel(
          categoryUseCase: gh<_i982.CategoryUseCase>(),
          brandsUseCase: gh<_i289.BrandsUseCase>(),
        ));
    gh.lazySingleton<_i37.LoginUseCase>(
        () => _i37.LoginUseCase(authRepository: gh<_i961.AuthRepository>()));
    gh.lazySingleton<_i97.RegisterUseCase>(
        () => _i97.RegisterUseCase(authRepository: gh<_i961.AuthRepository>()));
    gh.factory<_i617.RegisterViewModel>(() =>
        _i617.RegisterViewModel(registerUseCase: gh<_i97.RegisterUseCase>()));
    gh.factory<_i89.LoginViewModel>(
        () => _i89.LoginViewModel(loginUseCase: gh<_i37.LoginUseCase>()));
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}
