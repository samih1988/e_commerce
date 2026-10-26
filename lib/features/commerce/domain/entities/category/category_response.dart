


import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/common/meta_data.dart';

class CategoryResponse {
  final int? results;
  final MetaData? metadata;
  final List<Category>? data;

  CategoryResponse ({
    this.results,
    this.metadata,
    this.data,
  });


}






