import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_daman/core/constants/common_constants.dart';
import 'package:portfolio_daman/modules/home/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();
  final sectionKeys = <String, GlobalKey>{
    'home': GlobalKey(),
    'stats': GlobalKey(),
    'about': GlobalKey(),
    'services': GlobalKey(),
    'projects': GlobalKey(),
    'testimonials': GlobalKey(),
    'resume': GlobalKey(),
    'skills': GlobalKey(),
    'skills2': GlobalKey(),
    'contact': GlobalKey(),
  };
  final activeSection = 'home'.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    double minOffset = double.infinity;
    String? currentSection;
    sectionKeys.forEach((name, key) {
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero, ancestor: null).dy;
        if (offset.abs() < minOffset) {
          minOffset = offset.abs();
          currentSection = name;
        }
      }
    });
    if (currentSection != null && currentSection != activeSection.value) {
      activeSection.value = currentSection!;
    }
  }

  void scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      activeSection.value = section;
    }
  }

  void onClickViewWork() {
    print('onClickViewWork');
    scrollToSection('projects');
  }

  void onClickGetInTouch() {
    print('onClickGetInTouch');
    scrollToSection('contact');
  }

  onClickDownloadCv() {
    // You can implement CV download logic here
    // For example, open a URL to download CV
    const cvUrl = 'https://your-cv-url.com/cv.pdf';
    launchUrl(Uri.parse(cvUrl), mode: LaunchMode.externalApplication);
  }

  onClickProjectView({required ProjectModel project}) {
    Get.toNamed('/project-detail', arguments: project);
  }

  onClickSendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: CommonConstants.email,
      queryParameters: {
        'cc': CommonConstants.cc,
        'subject': 'New Contact Form Submission from $name',
        'body': message,
      },
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Could not open email app')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
