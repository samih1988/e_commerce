import 'package:e_commerce_app/features/commerce/domain/usecases/brands_use_case.dart';
import 'package:e_commerce_app/features/commerce/domain/usecases/category_use_case.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/home_tab/cubit/home_tab_state.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabState> {
  final CategoryUseCase categoryUseCase;
  final BrandsUseCase brandsUseCase;

  HomeTabViewModel({
    required this.categoryUseCase,
    required this.brandsUseCase,
  }) : super(HomeTabState.initial());

  void initHomeData() {
    getCategories();
    getBrands();
  }

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesState: ResourceState.loading()));
    try {
      final result = await categoryUseCase();
      if (result.haseData) {
        emit(state.copyWith(
          categoriesState: ResourceState.success(data: result.getData),
        ));
      } else {
        emit(state.copyWith(
          categoriesState: ResourceState.error(errorMessage: result.getError),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        categoriesState: ResourceState.error(errorMessage: e.toString()),
      ));
    }
  }

  Future<void> getBrands() async {
    emit(state.copyWith(brandsState: ResourceState.loading()));
    try {
      final result = await brandsUseCase();
      if (result.haseData) {
        emit(state.copyWith(
          brandsState: ResourceState.success(data: result.getData),
        ));
      } else {
        emit(state.copyWith(
          brandsState: ResourceState.error(errorMessage: result.getError),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        brandsState: ResourceState.error(errorMessage: e.toString()),
      ));
    }
  }
}
