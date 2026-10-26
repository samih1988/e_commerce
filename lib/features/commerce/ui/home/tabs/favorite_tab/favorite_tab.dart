import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/common/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends StatelessWidget {
  // القائمة فارغة حالياً حتى يتم ربطها بالـ Wishlist API
  final List<Map<String, dynamic>> favoriteProducts = const [];

  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (favoriteProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 80.sp,
              color: AppColors.primary30Opacity,
            ),
            SizedBox(height: 16.h),
            Text(
              "No favorite items yet",
              style: AppStyles.medium18Header.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Items added to your favorites will appear here",
              style: AppStyles.regular14Text.copyWith(
                color: AppColors.hintTextColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FavoriteItem(
              product: favoriteProducts[index],
            ),
            itemCount: favoriteProducts.length,
          ),
        ),
      ],
    );
  }
}
