import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_text_field.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/core/utils/helper/validator_app.dart';
import 'package:nti_graduation_project/core/utils/widgets/app_dialog.dart';
import 'package:nti_graduation_project/core/utils/widgets/app_toast.dart';
import 'package:nti_graduation_project/features/app_section/view/widgets/image_picker_icon_option.dart';
import 'package:nti_graduation_project/features/app_section/view_model/account_cubit/account_cubit.dart';

import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';

import 'package:toastification/toastification.dart';

import '../../../../../core/routes/app_routes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const routeName = AppRoutes.accountRoute;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: "fathy@gmail.com");
  var nameController = TextEditingController(text: "fathy");
  var phoneController = TextEditingController(text: "01001289114");
  Uint8List? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: BlocListener<AccountCubit, AccountState>(
              listener: (context, state) {
                if (state is AccountLoading) {
                  AppDialogs.showLoadingDialog(context);
                  return;
                }
                Navigator.of(context, rootNavigator: true).pop();
                if (state is AccountError) {
                  AppToast.showToast(
                    context: context,
                    title: 'Error',
                    description: state.errorMessage,
                    type: ToastificationType.error,
                  );
                }
                if (state is AccountSucess) {
                  AppToast.showToast(
                    context: context,
                    title: 'Success',
                    description: 'Account created successfully',
                    type: ToastificationType.success,
                  );

                  Navigator.of(context).pop();
                }
              },
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: _image != null
                              ? MemoryImage(_image!)
                              : NetworkImage(
                                  "https://tse2.mm.bing.net/th/id/OIP.wvRIhOFzGU982n--4ZGBMgHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                                ),
                        ),
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: IconButton(
                            onPressed: () {
                              showImagePickerOption(context);
                            },
                            icon: Icon(Icons.camera_alt),
                            iconSize: 42,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Text("Full Name", style: AppTextStyle.kTextStyleRegular18),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: nameController,
                    validator: Validator.validateName,
                    hintText: "Enter your Full Name",
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 16),
                  Text("Email", style: AppTextStyle.kTextStyleRegular18),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: emailController,
                    validator: Validator.validateEmail,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 16),
                  Text("Phone Number", style: AppTextStyle.kTextStyleRegular18),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: phoneController,
                    validator: Validator.validatePhoneNumber,
                    hintText: "Enter your Phone Number ",
                    keyboardType: TextInputType.phone,
                    action: TextInputAction.next,
                  ),
                  Expanded(child: SizedBox()),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var request = ProfileEntity(
                          email: emailController.text,
                          name: nameController.text,
                          phone: nameController.text,
                          image: _image.toString(),
                        );
                        context.read<AccountCubit>().intent(
                          AccountIntintEdite(request),
                        );
                        Navigator.of(context).pushNamed(AppRoutes.accountRoute);
                      }
                    },
                    text: "Submit",
                    backgroundColor: AppColorStyle.secondaryButtonColor,
                    textColor: AppColorStyle.disabledButtonColor,
                    borderColor: AppColorStyle.secondaryButtonColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pickImageGallary() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    _image = File(picked.path).readAsBytesSync();
    setState(() {});
  }

  void pickImageCamera() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked == null) return;
    _image = File(picked.path).readAsBytesSync();
    setState(() {});
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Expanded(
                  child: ImagePickerIconOption(
                    iconName: "Camera",
                    iconData: Icons.camera_alt_rounded,
                    onTap: () {
                      pickImageCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: ImagePickerIconOption(
                    iconName: "Gallary",
                    iconData: Icons.image,
                    onTap: () {
                      pickImageGallary();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
