import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
import 'package:nti_graduation_project/features/app_section/view_model/account_cubit/get_account_cubit.dart';
import 'package:nti_graduation_project/features/app_section/view_model/account_cubit/get_account_state.dart';
import 'package:nti_graduation_project/features/account/domain/entities/account_entity.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/routes/app_routes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const routeName = AppRoutes.accountRoute;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  Uint8List? _image;
  String? _networkImageUrl;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    setState(() {});
    context.read<GetAccountCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<GetAccountCubit, GetAccountState>(
              listener: (context, state) {
                if (state is GetAccountSucess) {}
              },
            ),
            BlocListener<AccountCubit, AccountState>(
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
                    description: 'Account updated successfully',
                    type: ToastificationType.success,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<GetAccountCubit, GetAccountState>(
            builder: (context, state) {
              if (state is GetAccountLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is GetAccountError) {
                return Center(child: Text("GetAccountError"));
              }
              if (state is GetAccountSucess) {
                nameController.text = state.data.message!.name;
                emailController.text = state.data.message!.email;
                phoneController.text = state.data.message!.phone;
                addressController.text = state.data.message!.address;

                _networkImageUrl = state.data.message!.image;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundImage: _image != null
                                      ? MemoryImage(_image!)
                                      : const NetworkImage(
                                              "https://tse2.mm.bing.net/th/id/OIP.wvRIhOFzGU982n--4ZGBMgHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                                            )
                                            as ImageProvider,
                                ),
                                Positioned(
                                  right: 1,
                                  bottom: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      showImagePickerOption(context);
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                    iconSize: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            "Full Name",
                            style: AppTextStyle.kTextStyleRegular18,
                          ),
                          const SizedBox(height: 5),
                          CustomTextFormField(
                            controller: nameController,
                            validator: Validator.validateName,
                            hintText: state.data.message?.name,
                            keyboardType: TextInputType.text,
                            action: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Email",
                            style: AppTextStyle.kTextStyleRegular18,
                          ),
                          const SizedBox(height: 5),
                          CustomTextFormField(
                            controller: emailController,
                            validator: Validator.validateEmail,
                            hintText: state.data.message?.email,
                            keyboardType: TextInputType.emailAddress,
                            action: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Phone Number",
                            style: AppTextStyle.kTextStyleRegular18,
                          ),
                          const SizedBox(height: 5),
                          CustomTextFormField(
                            controller: phoneController,
                            validator: Validator.validatePhoneNumber,
                            hintText: state.data.message?.phone,
                            keyboardType: TextInputType.phone,
                            action: TextInputAction.done,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Address",
                            style: AppTextStyle.kTextStyleRegular18,
                          ),
                          const SizedBox(height: 5),
                          CustomTextFormField(
                            controller: addressController,
                            validator: Validator.validateName,
                            hintText: state.data.message?.address,
                            keyboardType: TextInputType.emailAddress,
                            action: TextInputAction.done,
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                String? imageString = _image != null
                                    ? base64Encode(_image!)
                                    : _networkImageUrl;

                                var request = ProfileEntity(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  image: imageString.toString(),
                                );

                                context.read<AccountCubit>().intent(
                                  AccountIntintEdite(request),
                                );
                              }
                            },
                            text: "Submit",
                            backgroundColor: AppColorStyle.secondaryButtonColor,
                            textColor: AppColorStyle.disabledButtonColor,
                            borderColor: AppColorStyle.secondaryButtonColor,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
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
    _image = await picked.readAsBytes();
    setState(() {});
  }

  void pickImageCamera() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked == null) return;
    _image = await picked.readAsBytes();
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
