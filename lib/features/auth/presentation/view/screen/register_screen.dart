import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_text_field.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/utils/app_dialog.dart';
import 'package:nti_graduation_project/core/utils/app_toast.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/core/utils/validator_app.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';
import 'package:nti_graduation_project/features/auth/presentation/view_model/register/register_cubit.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: "fathy@gmail.com");
  var passwordController = TextEditingController(text: "Fathy123!");
  var confirmPasswordController = TextEditingController(text: "Fathy123!");
  var nameController = TextEditingController(text: "fathy");
  var phoneController = TextEditingController(text: "01001289114");
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
        title: Text("SignUp", style: AppTextStyle.kTextStyleSemiBold22),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoding) {
                AppDialogs.showLoadingDialog(context);
                return;
              }
              if (state is RegisterErorr || state is RegisterSuccess) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              }
              if (state is RegisterErorr) {
                AppToast.showToast(
                  context: context,
                  title: 'Error',
                  description: state.massage,
                  type: ToastificationType.error,
                );
              }
              if (state is RegisterSuccess) {
                AppToast.showToast(
                  context: context,
                  title: 'Success',
                  description: 'Account created successfully',
                  type: ToastificationType.success,
                );
                Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.loginRoute);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text("Full Name", style: AppTextStyle.kTextStyleRegular18),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: nameController,
                  validator: Validator.validateName,
                  hintText: "Enter your Full Name",
                  keyboardType: TextInputType.text,
                  action: TextInputAction.next,
                ),
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
                Text("Phone Number", style: AppTextStyle.kTextStyleRegular18),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: phoneController,
                  validator: Validator.validatePhoneNumber,
                  hintText: "Enter your Phone Number ",
                  keyboardType: TextInputType.phone,
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
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                Text(
                  "Confirm Password",
                  style: AppTextStyle.kTextStyleRegular18,
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  validator: (value) => Validator.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                  hintText: "Enter your confirm password",
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.done,
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: "Sign up",
                  backgroundColor: AppColorStyle.lightButtonColor,
                  textColor: AppColorStyle.bottomNavigationBarBackgroundColor,
                  borderColor: AppColorStyle.primaryButtonColor,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var requst = RegisterRequestEntity(
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                      );
                      context.read<RegisterCubit>().intent(
                        RegisterIntintRegister(requst),
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
                  text: "Already have an account? ",
                  style: AppTextStyle.kTextStyleRegular14.copyWith(
                    color: AppColorStyle.secondaryButtonColor,
                  ),

                  children: [
                    TextSpan(
                      text: "Login",
                      style: AppTextStyle.kTextStyleBold14.copyWith(
                        color: AppColorStyle.secondaryButtonColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed(AppRoutes.loginRoute);
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
