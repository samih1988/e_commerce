import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/common/widgets/custom_badge.dart';
import 'package:e_commerce_app/features/common/widgets/custom_bottom_nav_bar.dart';


import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/features/commerce/ui/home/cubit/home_screen_states.dart';
import 'package:e_commerce_app/features/commerce/ui/home/cubit/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel,HomeScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(viewModel.selectedIndex),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child:viewModel. bodyList[viewModel.selectedIndex],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: viewModel.selectedIndex,
            onTap: viewModel.bottomNavOnTap,
            backgroundColor: AppColors.primaryColor,
            selectedCircleColor: AppColors.whiteColor,
            circleRadius: 24.r,
            iconSize: 22.sp,
            items: const [
              CustomBottomNavItem(
                selectedAsset: AppAssets.selectedHomeIcon,
                unselectedAsset: AppAssets.unSelectedHomeIcon,
              ),
              CustomBottomNavItem(
                selectedAsset: AppAssets.selectedCategoryIcon,
                unselectedAsset: AppAssets.unSelectedCategoryIcon,
              ),
              CustomBottomNavItem(
                selectedAsset: AppAssets.selectedFavouriteIcon,
                unselectedAsset: AppAssets.unSelectedFavouriteIcon,
              ),
              CustomBottomNavItem(
                selectedAsset: AppAssets.selectedAccountIcon,
                unselectedAsset: AppAssets.unSelectedAccountIcon,
              ),
            ],
          ),
        );
      },
    );
  }

  OutlineInputBorder _buildCustomBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50.r));
  }

  PreferredSizeWidget _buildAppBar(int index) {
    return AppBar(
      surfaceTintColor: AppColors.transparentColor,
      elevation: 0,
      toolbarHeight: index != 3 ? 120.h : kToolbarHeight,
      leadingWidth: double.infinity,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Image.asset(
                AppAssets.routeLogo,
                width: 66.w,
                height: 22.h,
              ),
            ),
            Visibility(
              visible: index != 3,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          style: AppStyles.regular14Text,
                          cursorColor: AppColors.primaryColor,
                          onTap: () {
                            //todo: implement search logic
                          },
                          decoration: InputDecoration(
                              border: _buildCustomBorder(),
                              enabledBorder: _buildCustomBorder(),
                              focusedBorder: _buildCustomBorder(),
                              contentPadding: EdgeInsets.all(16.h),
                              hintStyle: AppStyles.light14SearchHint,
                              hintText: "what do you search for?",
                              prefixIcon: Icon(
                                Icons.search,
                                size: 30.sp,
                                color: AppColors.primaryColor.withOpacity(0.75),
                              ))),
                    ),
                    const CustomAppBarBadge(count: 5)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
