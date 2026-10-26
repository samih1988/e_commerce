import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class ProductState {
  late ResourceState<List<Product>> productState;
  ProductState({required this.productState});

  ProductState.initial(){
    productState=ResourceState.initial();
  }
}