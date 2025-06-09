import 'dart:ui';

import 'package:get/get.dart';
import 'package:portfolio_daman/core/constants/app_strings.dart';
import 'package:portfolio_daman/core/constants/image_resources.dart';

enum ProjectType {
  QuoteThat,
  FlippBidd,
  Chronifi,
  Albatroz,
  RetailPharmacies,
  Retail_Visual_Ui_builder,
  Telecey,
  Mysticly,
  Puls,
  PrimeTrainers, // ✅ Add this
  LikePlay ,
  SocialX// ✅ Add this

}

final List<ProjectModel> projectsList = [
  ProjectModel(
    projectType: ProjectType.FlippBidd,
    imagePath: ImageResources.flippbiddThumbMail,
    title: AppStrings.projectFlippBidd.tr,
    subtitle: AppStrings.projectFlippBiddSubtitle.tr,
    bgColor: Color(0xFFE3F0FF),
    description: AppStrings.projectFlippBiddDescription.tr,
    features: AppStrings.projectFlippBiddFeatures.tr,
    technologiesUsed: AppStrings.projectFlippBiddTech.tr,
    challenges: AppStrings.projectFlippBiddChallenges.tr,
    solution: AppStrings.projectFlippBiddSolution.tr,
    projectImages: [
      ImageResources.flippbiddZero,
      ImageResources.flippbiddOne,
      ImageResources.flippbiddTwo,
      ImageResources.flippbiddThree,
      ImageResources.flippbiddFour,
      ImageResources.flippbiddFive,
      ImageResources.flippbiddSix,
      ImageResources.flippbiddSeven,
      ImageResources.flippbiddEight,
    ],
    playStoreLink:
        "https://play.google.com/store/apps/details?id=com.flippbidd&hl=en_IN",
    appStoreLink: "https://apps.apple.com/in/app/flippbidd/id1365739399",
    projectUrl: "https://flippbidd.com/",
  ),
  ProjectModel(
    projectType: ProjectType.QuoteThat,
    imagePath: ImageResources.quoteThatIcon,
    title: AppStrings.projectQuoteThat.tr,
    subtitle: AppStrings.projectQuoteThatSubtitle.tr,
    bgColor: Color(0xFFFFF8E1),
    description: AppStrings.projectQuoteThatDescription.tr,
    features: AppStrings.projectQuoteThatFeatures.tr,
    technologiesUsed: AppStrings.projectQuoteThatTech.tr,
    challenges: AppStrings.projectQuoteThatChallenges.tr,
    solution: AppStrings.projectQuoteThatSolution.tr,
    projectImages: [
      ImageResources.quoteThatOne,
      ImageResources.quoteThatTwo,
      ImageResources.quoteThatThree,
      ImageResources.quoteThatFour,
      ImageResources.projectQuoteThat,
    ],
    playStoreLink:
        "https://play.google.com/store/apps/details?id=com.quotethat.today&hl=en_IN",
    appStoreLink: "https://apps.apple.com/us/app/quote-that-today/id6742242380",
    projectUrl: "https://www.quotethat.today/",
  ),
/*  ProjectModel(
    projectType: ProjectType.PrimeTrainers,
    imagePath: ImageResources.primeTrainerThumb,
    title: AppStrings.projectPrimeTrainersTitle.tr,
    subtitle: AppStrings.projectPrimeTrainersSubtitle.tr,
    bgColor: Color(0xFFE8F5E9),
    description: AppStrings.projectPrimeTrainersDescription.tr,
    features: AppStrings.projectPrimeTrainersFeatures.tr,
    technologiesUsed: AppStrings.projectPrimeTrainersTech.tr,
    challenges: AppStrings.projectPrimeTrainersChallenges.tr,
    solution: AppStrings.projectPrimeTrainersSolution.tr,
    projectImages: [
      ImageResources.primeTrainerOne,
      ImageResources.primeTrainerTwo,
    ],
    playStoreLink: "",
    appStoreLink: "",
    projectUrl: "https://primetrainers.com/",
  ),*/
  ProjectModel(
    projectType: ProjectType.LikePlay,
    imagePath: ImageResources.LikePlayThumb,
    title: AppStrings.projectLikePlayTitle.tr,
    subtitle: AppStrings.projectLikePlaySubtitle.tr,
    bgColor: Color(0xFFFFEBEE),
    description: AppStrings.projectLikePlayDescription.tr,
    features: AppStrings.projectLikePlayFeatures.tr,
    technologiesUsed: AppStrings.projectLikePlayTech.tr,
    challenges: AppStrings.projectLikePlayChallenges.tr,
    solution: AppStrings.projectLikePlaySolution.tr,
    projectImages: [
      ImageResources.LikePlayOne,
      ImageResources.LikePlayTwo,
      ImageResources.LikePlayThree,
    ],
    playStoreLink: "https://play.google.com/store/apps/details?id=com.sfs.likeplay",
    appStoreLink: "",
    projectUrl: "https://www.likeplaylikeplay.com/",
  ),
/*  ProjectModel(
    projectType: ProjectType.ownUrHealth,
    imagePath: ImageResources.ownUrHealthThumb,
    title: AppStrings.projectOwnUrHealth.tr,
    subtitle: AppStrings.projectOwnUrHealthSubtitle.tr,
    bgColor: Color(0xFFEDE7F6),
    description: AppStrings.projectOwnUrHealthDescription.tr,
    features: AppStrings.projectOwnUrHealthFeatures.tr,
    technologiesUsed: AppStrings.projectOwnUrHealthTech.tr,
    challenges: AppStrings.projectOwnUrHealthChallenges.tr,
    solution: AppStrings.projectOwnUrHealthSolution.tr,
    projectImages: [
      ImageResources.ownUrHealthOne,
      ImageResources.ownUrHealthTwo,
    ],
    playStoreLink: "",
    appStoreLink: "",
    projectUrl: "https://ownurhealth.com/",
  ),*/
  ProjectModel(
    projectType: ProjectType.SocialX,
    imagePath: ImageResources.socialXThumb,
    title: AppStrings.projectSocialX.tr,
    subtitle: AppStrings.projectSocialXSubtitle.tr,
    bgColor: Color(0xFFE1F5FE),
    description: AppStrings.projectSocialXDescription.tr,
    features: AppStrings.projectSocialXFeatures.tr,
    technologiesUsed: AppStrings.projectSocialXTech.tr,
    challenges: AppStrings.projectSocialXChallenges.tr,
    solution: AppStrings.projectSocialXSolution.tr,
    projectImages: [
      ImageResources.socialXOne,
      ImageResources.socialXTwo,
      ImageResources.socialThree,
      ImageResources.socialFour,
      ImageResources.socialFive,
      ImageResources.socialSix,
      ImageResources.socialSeven,
    ImageResources.socialXThumb,
    ],
    playStoreLink: "",
    appStoreLink: "",
    projectUrl: "",
  ),
];

class ProjectModel {
  final Color bgColor;
  final ProjectType projectType;
  final String imagePath;
  List<String>? projectImages;
  final String title;
  final String subtitle;
  final String? description;
  final String? features;
  final String? technologiesUsed;
  final String? challenges;
  final String? solution;
  final String? playStoreLink;
  final String? appStoreLink;
  final String? projectUrl;

  ProjectModel({
    required this.projectType,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    this.description,
    this.technologiesUsed,
    this.features,
    this.projectImages,
    this.challenges,
    this.solution,
    this.playStoreLink,
    this.appStoreLink,
    this.projectUrl,
  });
}
