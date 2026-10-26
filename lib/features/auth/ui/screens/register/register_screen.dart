import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/common/resource_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../common/widgets/custom_elevated_button.dart';
import '../../../../common/widgets/custom_text_form_field.dart';
import 'cubit/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController =
      TextEditingController(text: "samih asaad");
  TextEditingController phoneController =
      TextEditingController(text: "01221952339");
  TextEditingController mailController =
      TextEditingController(text: "samih_2026@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "sam@12345");
  TextEditingController rePasswordController =
      TextEditingController(text: "sam@12345");

  RegisterViewModel viewModel = getIt<RegisterViewModel>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordObscured = true;
  bool isRePasswordObscured = true;

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    mailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel, ResourceState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state.isLoading) {
          DialogUtils.showLoading(context: context, message: 'Loading...');
        } else if (state.isError) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: state.errorMessage ?? 'Something went wrong',
              title: 'Error',
              posActionName: 'Ok');
        } else if (state.isSuccess) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Register Successfully',
              title: 'Success',

              );
          Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);

        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 91.h, bottom: 10.h, left: 97.w, right: 97.w),
                child: Image.asset(
                  AppAssets.appBarLeading,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Full Name",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: false,
                              keyboardType: TextInputType.name,
                              isObscureText: false,
                              hintText: "enter your full name",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: fullNameController,
                              validator: AppValidators.validateFullName,
                            ),
                            Text(
                              "Mobile Number",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.phone,
                                isObscureText: false,
                                hintText: "enter your mobile number",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: phoneController,
                                validator: AppValidators.validatePhoneNumber),
                            Text(
                              "E-mail address",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.emailAddress,
                                isObscureText: false,
                                hintText: "enter your email address",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: mailController,
                                validator: AppValidators.validateEmail),
                            Text(
                              "Password",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: isPasswordObscured,
                              hintText: "enter your password",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: passwordController,
                              validator: AppValidators.validatePassword,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordObscured =
                                      !isPasswordObscured;
                                    });
                                  },
                                  icon: Icon(isPasswordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            ),
                            Text(
                              "RePassword",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: isRePasswordObscured,
                              hintText: "enter your password again",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: rePasswordController,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isRePasswordObscured =
                                          !isRePasswordObscured;
                                    });
                                  },
                                  icon: Icon(isRePasswordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                              validator: (value) {
                                return AppValidators.validateConfirmPassword(
                                    value, passwordController.text);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: CustomElevatedButton(
                                  backgroundColor: AppColors.whiteColor,
                                  textStyle: AppStyles.semi20Primary,
                                  text: "Sign up",
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ==
                                        true) {
                                      viewModel.register(
                                          email: mailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          name: fullNameController.text.trim(),
                                          rePassword:
                                              rePasswordController.text.trim());
                                    }
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.loginRoute);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        'Already have an account? login',
                                        style: AppStyles.medium18White,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
