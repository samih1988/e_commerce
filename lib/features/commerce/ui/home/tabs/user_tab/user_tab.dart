import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/core/chach/shared_preferencse_utils.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/flutter_toast.dart';
import 'package:e_commerce_app/features/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController =
      TextEditingController(text: "**********");
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode mobileFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  bool fullNameReadOnly = true;
  bool emailReadOnly = true;
  bool passwordReadOnly = true;
  bool mobileReadOnly = true;
  bool addressReadOnly = true;

  final SharedPreferencseUtils prefs = getIt<SharedPreferencseUtils>();
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    userName = prefs.getString('userName') ?? 'User';
    userEmail = prefs.getString('userEmail') ?? '';
    final userPhone = prefs.getString('userPhone') ?? '';
    final userAddress = prefs.getString('userAddress') ?? '';

    fullNameController.text = userName;
    emailController.text = userEmail;
    mobileController.text = userPhone;
    addressController.text = userAddress;
    setState(() {});
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    addressController.dispose();

    fullNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    mobileFocus.dispose();
    addressFocus.dispose();
    super.dispose();
  }

  Future<void> _saveField({
    required String key,
    required String value,
    required String fieldName,
  }) async {
    await prefs.saveData(key: key, value: value);
    ToastMessage.toastMsg(
      "$fieldName updated successfully",
      AppColors.greenColor,
      AppColors.whiteColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Welcome, $userName",
                  style: AppStyles.medium18Header,
                ),
                IconButton(
                  onPressed: () async {
                    await prefs.removeData(key: 'token');
                    await prefs.removeData(key: 'userName');
                    await prefs.removeData(key: 'userEmail');
                    await prefs.removeData(key: 'userPhone');
                    await prefs.removeData(key: 'userAddress');

                    if (!mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.loginRoute,
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
            AutoSizeText(
              userEmail,
              style: AppStyles.medium14LightPrimary,
            ),
            SizedBox(height: 30.h),

            // 1. Full Name Field
            AutoSizeText(
              "Your full name",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isPassword: false,
              readonly: fullNameReadOnly,
              focusNode: fullNameFocus,
              keyboardType: TextInputType.name,
              controller: fullNameController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(
                onPressed: () async {
                  if (fullNameReadOnly) {
                    setState(() => fullNameReadOnly = false);
                    fullNameFocus.requestFocus();
                  } else {
                    fullNameFocus.unfocus();
                    setState(() {
                      fullNameReadOnly = true;
                      userName = fullNameController.text;
                    });
                    await _saveField(
                      key: 'userName',
                      value: fullNameController.text,
                      fieldName: 'Name',
                    );
                  }
                },
                icon: Icon(
                  fullNameReadOnly ? Icons.edit : Icons.check_circle,
                  color: fullNameReadOnly ? null : AppColors.greenColor,
                ),
              ),
              textStyle: AppStyles.medium14PrimaryDark,
            ),

            // 2. Email Field
            AutoSizeText(
              "Your E-mail",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              readonly: emailReadOnly,
              focusNode: emailFocus,
              isPassword: false,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(
                onPressed: () async {
                  if (emailReadOnly) {
                    setState(() => emailReadOnly = false);
                    emailFocus.requestFocus();
                  } else {
                    emailFocus.unfocus();
                    setState(() {
                      emailReadOnly = true;
                      userEmail = emailController.text;
                    });
                    await _saveField(
                      key: 'userEmail',
                      value: emailController.text,
                      fieldName: 'Email',
                    );
                  }
                },
                icon: Icon(
                  emailReadOnly ? Icons.edit : Icons.check_circle,
                  color: emailReadOnly ? null : AppColors.greenColor,
                ),
              ),
              textStyle: AppStyles.medium14PrimaryDark,
            ),

            // 3. Password Field
            AutoSizeText(
              "Your password",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isObscureText: true,
              readonly: passwordReadOnly,
              focusNode: passwordFocus,
              isPassword: false,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(
                onPressed: () {
                  if (passwordReadOnly) {
                    setState(() => passwordReadOnly = false);
                    passwordFocus.requestFocus();
                  } else {
                    passwordFocus.unfocus();
                    setState(() => passwordReadOnly = true);
                  }
                },
                icon: Icon(
                  passwordReadOnly ? Icons.edit : Icons.check_circle,
                  color: passwordReadOnly ? null : AppColors.greenColor,
                ),
              ),
              textStyle: AppStyles.medium14PrimaryDark,
            ),

            // 4. Mobile Number Field
            AutoSizeText(
              "Your mobile number",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isPassword: false,
              readonly: mobileReadOnly,
              focusNode: mobileFocus,
              keyboardType: TextInputType.phone,
              controller: mobileController,
              hintText: "Enter your phone number",
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(
                onPressed: () async {
                  if (mobileReadOnly) {
                    setState(() => mobileReadOnly = false);
                    mobileFocus.requestFocus();
                  } else {
                    mobileFocus.unfocus();
                    setState(() => mobileReadOnly = true);
                    await _saveField(
                      key: 'userPhone',
                      value: mobileController.text,
                      fieldName: 'Mobile number',
                    );
                  }
                },
                icon: Icon(
                  mobileReadOnly ? Icons.edit : Icons.check_circle,
                  color: mobileReadOnly ? null : AppColors.greenColor,
                ),
              ),
              textStyle: AppStyles.medium14PrimaryDark,
            ),

            // 5. Address Field
            AutoSizeText(
              "Your Address",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isPassword: false,
              readonly: addressReadOnly,
              focusNode: addressFocus,
              keyboardType: TextInputType.streetAddress,
              controller: addressController,
              hintText: "Enter your address",
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(
                onPressed: () async {
                  if (addressReadOnly) {
                    setState(() => addressReadOnly = false);
                    addressFocus.requestFocus();
                  } else {
                    addressFocus.unfocus();
                    setState(() => addressReadOnly = true);
                    await _saveField(
                      key: 'userAddress',
                      value: addressController.text,
                      fieldName: 'Address',
                    );
                  }
                },
                icon: Icon(
                  addressReadOnly ? Icons.edit : Icons.check_circle,
                  color: addressReadOnly ? null : AppColors.greenColor,
                ),
              ),
              textStyle: AppStyles.medium14PrimaryDark,
            ),
          ],
        ),
      ),
    );
  }
}
