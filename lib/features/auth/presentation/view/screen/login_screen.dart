import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_text_field.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/utils/widgets/app_dialog.dart';
import 'package:nti_graduation_project/core/utils/widgets/app_toast.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/core/utils/helper/validator_app.dart';
import 'package:nti_graduation_project/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "fathy@gmail.com");
  final passwordController = TextEditingController(text: "Fathy123!");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Text("Login", style: AppTextStyle.kTextStyleSemiBold22),
        centerTitle: true,
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoding) {
            AppDialogs.showLoadingDialog(context);
            return;
          }

          Navigator.of(context, rootNavigator: true).pop();
          if (state is LoginError) {
            AppToast.showToast(
              context: context,
              title: "Error",
              description: state.massage,
              type: ToastificationType.error,
            );
          }
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text("Email", style: AppTextStyle.kTextStyleRegular18),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                Text("Password", style: AppTextStyle.kTextStyleRegular18),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: passwordController,
                  validator: Validator.validatePassword,
                  hintText: "Enter your password",
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),

                CustomButton(
                  text: "Login",
                  backgroundColor: AppColorStyle.lightButtonColor,
                  textColor: AppColorStyle.bottomNavigationBarBackgroundColor,
                  borderColor: AppColorStyle.primaryButtonColor,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginCubit>().intent(
                        LoginIntintLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: AppTextStyle.kTextStyleRegular14.copyWith(
                    color: AppColorStyle.secondaryButtonColor,
                  ),

                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: AppTextStyle.kTextStyleBold14.copyWith(
                        color: AppColorStyle.secondaryButtonColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.signupRoute);
                        },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
