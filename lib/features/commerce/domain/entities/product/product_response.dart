
import 'package:e_commerce_app/features/commerce/domain/entities/common/meta_data.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';

class ProductResponse {
  final int? results;
  final MetaData? metadata;
  final List<Product>? data;

  ProductResponse ({
    this.results,
    this.metadata,
    this.data,
  });


}







