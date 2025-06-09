import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class SkillModel {
  final String name;
  final IconData icon;
  const SkillModel(this.name, this.icon);
}

final List<SkillModel> skills = const [
  SkillModel(AppStrings.skillFlutter, Icons.flutter_dash),
  SkillModel(AppStrings.skillProgramming, Icons.code),
  SkillModel(AppStrings.skillStateManagement, Icons.sync_alt),
  SkillModel(AppStrings.skillUiUx, Icons.design_services),
  SkillModel(AppStrings.skillFastDevelopment, Icons.flash_on),
  SkillModel(AppStrings.skillCodeQuality, Icons.verified),
  SkillModel(AppStrings.skillPerformance, Icons.speed),
  SkillModel(AppStrings.skillTesting, Icons.bug_report),
  SkillModel(AppStrings.skillDebugging, Icons.build),
  SkillModel(AppStrings.skillAppStore, Icons.cloud_upload),
];

class SkillCardModel {
  final String title;
  final String desc;
  final IconData icon;
  const SkillCardModel(this.title, this.desc, this.icon);
}

final List<SkillCardModel> skillCards = const [
  SkillCardModel(
    AppStrings.skillFlutter,
    AppStrings.skillFlutterDesc,
    Icons.flutter_dash,
  ),
  SkillCardModel(
    AppStrings.skillProgramming,
    AppStrings.skillProgrammingDesc,
    Icons.code,
  ),
  SkillCardModel(
    AppStrings.skillStateManagement,
    AppStrings.skillStateManagementDesc,
    Icons.sync_alt,
  ),
  SkillCardModel(
    AppStrings.skillUiUx,
    AppStrings.skillUiUxDesc,
    Icons.design_services,
  ),
  SkillCardModel(
    AppStrings.skillFastDevelopment,
    AppStrings.skillFastDevelopmentDesc,
    Icons.flash_on,
  ),
  SkillCardModel(
    AppStrings.skillCodeQuality,
    AppStrings.skillCodeQualityDesc,
    Icons.verified,
  ),
  SkillCardModel(
    AppStrings.skillPerformance,
    AppStrings.skillPerformanceDesc,
    Icons.speed,
  ),
  SkillCardModel(
    AppStrings.skillTesting,
    AppStrings.skillTestingDesc,
    Icons.bug_report,
  ),
  SkillCardModel(
    AppStrings.skillDebugging,
    AppStrings.skillDebuggingDesc,
    Icons.build,
  ),
  SkillCardModel(
    AppStrings.skillAppStore,
    AppStrings.skillAppStoreDesc,
    Icons.cloud_upload,
  ),
];
