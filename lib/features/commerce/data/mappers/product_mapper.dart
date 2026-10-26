import 'package:e_commerce_app/features/commerce/data/mappers/category_mapper.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/product/product.dart';
import 'package:e_commerce_app/features/network/models/response/product/product_dto.dart';

extension ProductMapper on ProductDto {
  Product toProduct() {
    return Product(
      id: id,
     title: title,
      category: category?.toEntity(),
      brand: brand?.toEntity(),
      createdAt: createdAt,
      description: description,
      imageCover: imageCover,
      images: images,
      price: price,
      quantity: quantity,
      ratingsAverage: ratingsAverage,
      ratingsQuantity: ratingsQuantity,
      slug: slug,
      sold: sold,
      subcategory: subcategory?.toCategoryList(),
      updatedAt: updatedAt

    );
  }
}


extension ProductListMapper on List<ProductDto>{
  List<Product> toProductList(){
    return map((dto)=>dto.toProduct()).toList();
  }
}