import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/network/models/response/common/category_dto.dart';

extension CategoryDtoMapper on CategoryDto {
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      slug: slug,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}


extension CategoryListMapper on List<CategoryDto>{
  List<Category> toCategoryList(){
    return map((dto)=>dto.toEntity()).toList();
  }
}