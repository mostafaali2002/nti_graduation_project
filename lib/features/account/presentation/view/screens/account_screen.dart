import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';

import '../../../../../core/routes/app_routes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const routeName = AppRoutes.accountRoute;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Uint8List? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: .center,
          children: [
            Stack(
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
                      pickImage();
                    },
                    icon: Icon(Icons.camera_alt),
                    iconSize: 42,
                  ),
                ),
              ],
            ),
            TextField(),
            Expanded(child: SizedBox()),
            CustomButton(
              onPressed: () {},
              text: "Submit",
              backgroundColor: AppColorStyle.secondaryButtonColor,
              textColor: AppColorStyle.disabledButtonColor,
              borderColor: AppColorStyle.secondaryButtonColor,
            ),
          ],
        ),
      ),
    );
  }

  void pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    _image = File(picked.path).readAsBytesSync();
    setState(() {});
  }
}
