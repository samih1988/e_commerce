
import 'package:e_commerce_app/core/utils/app_theme.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/my_bloc_observer.dart';
import 'features/auth/ui/screens/login/login_screen.dart';
import 'features/auth/ui/screens/register/register_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginRoute,
          routes: {
            AppRoutes.loginRoute: (context) => LoginScreen(),
            AppRoutes.registerRoute: (context) => RegisterScreen(),
            // AppRoutes.homeRoute: (context) => const HomeScreen(),
            // AppRoutes.cartRoute: (context) => const CartScreen(),
            // AppRoutes.productRoute: (context) => ProductDetailsScreen(),
          },
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
