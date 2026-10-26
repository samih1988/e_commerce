import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';

class HomeTabState {
  final ResourceState<List<Category>> categoriesState;
  final ResourceState<List<Category>> brandsState;

  HomeTabState({
    required this.categoriesState,
    required this.brandsState,
  });

  factory HomeTabState.initial() => HomeTabState(
        categoriesState: ResourceState.initial(),
        brandsState: ResourceState.initial(),
      );

  HomeTabState copyWith({
    ResourceState<List<Category>>? categoriesState,
    ResourceState<List<Category>>? brandsState,
  }) {
    return HomeTabState(
      categoriesState: categoriesState ?? this.categoriesState,
      brandsState: brandsState ?? this.brandsState,
    );
  }
}
