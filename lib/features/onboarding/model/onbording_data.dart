import 'package:nti_graduation_project/core/constant/app_assets.dart';

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
