import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/commerce/domain/entities/common/category.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/home_tab/cubit/home_tab_state.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:e_commerce_app/features/common/widgets/category_brand_item.dart';
import 'package:e_commerce_app/features/common/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/common/widgets/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  final List<String> announcementImages = const [
    AppAssets.announcement1,
    AppAssets.announcement2,
    AppAssets.announcement3,
  ];

  @override
  void initState() {
    super.initState();
    viewModel.initHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.initHomeData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            _buildAnnouncement(images: announcementImages),
            SizedBox(height: 24.h),

            // 1. Categories Section
            _lineBreak(name: "Categories"),
            BlocBuilder<HomeTabViewModel, HomeTabState>(
              bloc: viewModel,
              buildWhen: (previous, current) =>
                  previous.categoriesState != current.categoriesState,
              builder: (context, state) {
                if (state.categoriesState.isLoading) {
                  return const MainLoadingWidget();
                }
                if (state.categoriesState.isError) {
                  return MainErrorWidget(
                    errorMessage: state.categoriesState.errorMessage ??
                        'Failed to load categories',
                    onTryAgain: viewModel.getCategories,
                  );
                }
                return _buildCategoryBrandSec(state.categoriesState.data ?? []);
              },
            ),

            // 2. Brands Section
            _lineBreak(name: "Brands"),
            BlocBuilder<HomeTabViewModel, HomeTabState>(
              bloc: viewModel,
              buildWhen: (previous, current) =>
                  previous.brandsState != current.brandsState,
              builder: (context, state) {
                if (state.brandsState.isLoading) {
                  return const MainLoadingWidget();
                }
                if (state.brandsState.isError) {
                  return MainErrorWidget(
                    errorMessage: state.brandsState.errorMessage ??
                        'Failed to load brands',
                    onTryAgain: viewModel.getBrands,
                  );
                }
                return _buildCategoryBrandSec(state.brandsState.data ?? []);
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildCategoryBrandSec(List<Category> list) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
        ),
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryBrandItem(item: list[index]);
        },
      ),
    );
  }

  ImageSlideshow _buildAnnouncement({required List<String> images}) {
    return ImageSlideshow(
      indicatorColor: AppColors.primaryColor,
      initialPage: 0,
      indicatorBottomPadding: 15.h,
      indicatorPadding: 8.w,
      indicatorRadius: 5,
      indicatorBackgroundColor: AppColors.whiteColor,
      isLoop: true,
      autoPlayInterval: 3000,
      height: 190.h,
      children: images.map((url) {
        return Image.asset(url, fit: BoxFit.fill);
      }).toList(),
    );
  }

  Widget _lineBreak({required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: AppStyles.medium18Header),
        TextButton(
          onPressed: () {
            //todo: navigate to all
          },
          child: Text("View All", style: AppStyles.regular12Text),
        )
      ],
    );
  }
}
