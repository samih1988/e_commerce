import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';
import 'package:e_commerce_app/features/commerce/domain/usecases/product_use_case.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/products_tab/cubit/product_state.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductUseCase productUseCase;
  ProductCubit({required this.productUseCase}):super(ProductState.initial());

 Future<void> getAllProducts() async{
    emit(ProductState(productState: ResourceState.loading()));
    var result = await productUseCase();
    if(result.haseData){
emit(ProductState(productState: ResourceState.success(data: result.getData)));
    }else{
      emit(ProductState(productState: ResourceState.error(errorMessage: result.getError)));
    }

  }

}