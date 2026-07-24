import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/constant/app_assets.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});
  static const String routeName = AppRoutes.onBoarding;
  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  List<OnbordingData> onbordingData = dataOnbording();
  int currentIndex = 0;
  PageController controller = PageController();
  Future<void> saveOnBoarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setBool("onBoardingDone", true);
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstPage = currentIndex == 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorStyle.scaffoldBackgroundColor,
        elevation: 0,
        leading: isFirstPage
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColorStyle.secondaryButtonColor,
                ),
                onPressed: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
              ),
        actions: [
          if (isFirstPage)
            TextButton(
              onPressed: () async {
                await saveOnBoarding();
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, AppRoutes.helloRoute);
              },
              child: Text('Skip', style: AppTextStyle.kTextStyleRegular14),
            ),
        ],
      ),
      backgroundColor: AppColorStyle.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 315,
              width: 343,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomAnimatedWidget(
                      delay: (index) * 100,
                      index: index,
                      child: Image.asset(
                        onbordingData[index].image,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  );
                },
                itemCount: onbordingData.length,
              ),
            ),
            SizedBox(height: 8),
            SmoothPageIndicator(
              controller: controller,
              count: onbordingData.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 4,
                //!====================================
                dotColor: AppColorStyle.bottomNavigationBarBackgroundColor,
                activeDotColor: AppColorStyle.secondaryButtonColor,
              ),
            ),
            CustomAnimatedWidget(
              delay: (currentIndex + 1) * 100,
              index: currentIndex,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 69),
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      onbordingData[currentIndex].title,
                      style: AppTextStyle.kTextStyleBold22,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      onbordingData[currentIndex].description,
                      style: AppTextStyle.kTextStyleRegular16,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 56),
                  ],
                ),
              ),
            ),
            CustomButton(
              onPressed: () async {
                if (currentIndex == onbordingData.length - 1) {
                  await saveOnBoarding();

                  if (!context.mounted) return;

                  Navigator.pushReplacementNamed(context, AppRoutes.helloRoute);
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              text: onbordingData[currentIndex].bottomText,
              backgroundColor: AppColorStyle.lightButtonColor,
              textColor: AppColorStyle.whiteColor,
              borderColor: AppColorStyle.lightButtonColor,
            ),
          ],
        ),
      ),
    );
  }
}

class OnbordingData {
  final String image;
  final String title;
  final String description;
  final String bottomText;

  OnbordingData({
    required this.image,
    required this.title,
    required this.description,
    required this.bottomText,
  });
}

List<OnbordingData> dataOnbording() {
  return [
    OnbordingData(
      image: AppAssets.onboardingTwoImagePng,
      title: 'Discover Trends',
      description: 'Now we are here to provide variety of the best fashion',
      bottomText: 'Next',
    ),
    OnbordingData(
      image: AppAssets.onboardingOneImagePng,
      title: 'Latest out fit',
      description: 'Express your self through the art of the fashionism',
      bottomText: 'Get started',
    ),
  ];
}

class CustomAnimatedWidget extends StatelessWidget {
  const CustomAnimatedWidget({
    super.key,
    required this.index,
    required this.delay,
    required this.child,
  });

  final int index;
  final int delay;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }
}
