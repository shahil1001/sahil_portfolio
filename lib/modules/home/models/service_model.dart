import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/image_resources.dart';

class ServiceModel {
  final String imagePath;
  final String title;
  final String description;
  const ServiceModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

final List<ServiceModel> servicesList = [
  ServiceModel(
    imagePath: ImageResources.serviceCrossPlatform,
    title: AppStrings.serviceCrossPlatformTitle.tr,
    description: AppStrings.serviceCrossPlatformDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceFlutterSolutions,
    title: AppStrings.serviceFlutterSolutionsTitle.tr,
    description: AppStrings.serviceFlutterSolutionsDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceUiUxDesign,
    title: AppStrings.serviceUiUxDesignTitle.tr,
    description: AppStrings.serviceUiUxDesignDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceAnimations,
    title: AppStrings.serviceAnimationsTitle.tr,
    description: AppStrings.serviceAnimationsDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.servicePerformance,
    title: AppStrings.servicePerformanceTitle.tr,
    description: AppStrings.servicePerformanceDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceNativeCode,
    title: AppStrings.serviceNativeCodeTitle.tr,
    description: AppStrings.serviceNativeCodeDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceBugFixing,
    title: AppStrings.serviceBugFixingTitle.tr,
    description: AppStrings.serviceBugFixingDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceApiIntegration,
    title: AppStrings.serviceApiIntegrationTitle.tr,
    description: AppStrings.serviceApiIntegrationDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceSecureScalable,
    title: AppStrings.serviceSecureScalableTitle.tr,
    description: AppStrings.serviceSecureScalableDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceQualityAssurance,
    title: AppStrings.serviceQualityAssuranceTitle.tr,
    description: AppStrings.serviceQualityAssuranceDesc.tr,
  ),
  ServiceModel(
    imagePath: ImageResources.serviceAppStore,
    title: AppStrings.serviceAppStoreTitle.tr,
    description: AppStrings.serviceAppStoreDesc.tr,
  ),
];
