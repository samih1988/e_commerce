import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_brands_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeTabViewModel extends Cubit<HomeTabStates>{
  GetAllCategoriesUseCase getAllCategoriesUseCase ;
  GetAllBrandsUseCase getAllBrandsUseCase ;
  HomeTabViewModel({required this.getAllCategoriesUseCase,
  required this.getAllBrandsUseCase}):super(HomeTabInitialState());
  //todo: hold data - handle logic
  List<String> imagesList = [
    AppAssets.announcement1,
    AppAssets.announcement2,
    AppAssets.announcement3,
  ];

  HomeTabSuccessState successState = HomeTabSuccessState();

  Future<void> getCategories()async{
    try{
      emit(CategoryLoadingState());
      var categoriesList = await getAllCategoriesUseCase.invoke();
      emit(successState = successState.copyWith(categoriesList: categoriesList));
    }on AppException catch(e){
      emit(CategoryErrorState(message: e.message));
    }
  }
  Future<void> getBrands()async{
    try{
      emit(BrandLoadingState());
      var brandsList = await getAllBrandsUseCase.invoke();
      emit(successState = successState.copyWith(brandsList: brandsList));
    }on AppException catch(e){
      emit(BrandErrorState(message: e.message));
    }
  }
}