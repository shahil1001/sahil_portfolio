import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/image_resources.dart';
import 'package:flutter/material.dart';

class TestimonialModel {
  final String imagePath;
  final String name;
  final String role;
  final String quote;
  final Color bgColor;
  const TestimonialModel({
    required this.imagePath,
    required this.name,
    required this.role,
    required this.quote,
    required this.bgColor,
  });
}

final List<TestimonialModel> testimonialsList = [
  TestimonialModel(
    imagePath: ImageResources.testimonialJohn,
    name: AppStrings.testimonialJohnName.tr,
    role: AppStrings.testimonialJohnRole.tr,
    quote: AppStrings.testimonialJohnQuote.tr,
    bgColor: Color(0xFFE3F0FF),
  ),
  TestimonialModel(
    imagePath: ImageResources.testimonialAnna,
    name: AppStrings.testimonialAnnaName.tr,
    role: AppStrings.testimonialAnnaRole.tr,
    quote: AppStrings.testimonialAnnaQuote.tr,
    bgColor: Color(0xFFFFF8E1),
  ),
  TestimonialModel(
    imagePath: ImageResources.testimonialMike,
    name: AppStrings.testimonialMikeName.tr,
    role: AppStrings.testimonialMikeRole.tr,
    quote: AppStrings.testimonialMikeQuote.tr,
    bgColor: Color(0xFFE1F5FE),
  ),
  TestimonialModel(
    imagePath: ImageResources.testimonialLisa,
    name: AppStrings.testimonialLisaName.tr,
    role: AppStrings.testimonialLisaRole.tr,
    quote: AppStrings.testimonialLisaQuote.tr,
    bgColor: Color(0xFFF3E5F5),
  ),
];
