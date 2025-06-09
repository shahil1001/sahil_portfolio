import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_daman/modules/home/models/project_model.dart';
import 'package:portfolio_daman/modules/project_detail/screen/project_detail_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {



  late ProjectModel project;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  final isLoading = false.obs;
  final selectedImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // Get project from arguments
    if (Get.arguments != null && Get.arguments is ProjectModel) {
      project = Get.arguments as ProjectModel;
    } else {
      // Handle error case - go back to home
      Get.back();
      return;
    }

    // Initialize animations
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animations
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void onBackPressed() {
    Get.back();
  }

  void onImageTap(int index) {
    selectedImageIndex.value = index;
    Get.to(
          () => FullScreenImageViewer(
        images: project.projectImages!,
        initialIndex: index,
      ),
      transition: Transition.fadeIn,
    );
  }

  Future<void> onPlayStoreTap() async {
    if (project.playStoreLink != null && project.playStoreLink!.isNotEmpty) {
      await _launchUrl(project.playStoreLink!);
    } else {
      _showSnackBar('Play Store link not available for this project');
    }
  }

  Future<void> onAppStoreTap() async {
    if (project.appStoreLink != null && project.appStoreLink!.isNotEmpty) {
      await _launchUrl(project.appStoreLink!);
    } else {
      _showSnackBar('App Store link not available for this project');
    }
  }

  Future<void> onViewProjectTap() async {
    if (project.projectUrl != null && project.projectUrl!.isNotEmpty) {
      await _launchUrl(project.projectUrl!);
    } else {
      _showSnackBar('Project URL not available');
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Could not open URL: $url');
      }
    } catch (e) {
      _showSnackBar('Error opening URL: $e');
    }
  }

  void _showSnackBar(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  // Animation helpers
  Animation<double> getStaggeredAnimation(double delay) {
    final endTime = (delay + 0.4).clamp(0.0, 1.0);
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(delay.clamp(0.0, 0.6), endTime, curve: Curves.easeOut),
      ),
    );
  }

  Animation<Offset> getSlideAnimation(double delay) {
    final endTime = (delay + 0.4).clamp(0.0, 1.0);
    return Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(delay.clamp(0.0, 0.6), endTime, curve: Curves.easeOut),
      ),
    );
  }
}
