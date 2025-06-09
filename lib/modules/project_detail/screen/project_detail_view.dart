import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart' show PhotoViewGallery, PhotoViewGalleryPageOptions;
import 'package:portfolio_daman/core/constants/app_strings.dart';
import 'package:portfolio_daman/modules/project_detail/controller/project_detail_controller.dart';
import 'package:portfolio_daman/modules/project_detail/extension/project_detail_extension.dart';

class ProjectDetailView extends GetView<ProjectDetailController> {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: controller.fadeAnimation,
              child: SlideTransition(
                position: controller.slideAnimation,
                child: _buildContent(context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.maxContentWidth),
              child: Padding(
                padding: context.responsivePadding,
                child: Column(
                  children: [
                    _buildHeroSection(context),
                    SizedBox(height: context.verticalSpacing),
                    _buildProjectInfo(context),
                    SizedBox(height: context.verticalSpacing),
                    _buildActionButtons(context),
                    SizedBox(height: context.verticalSpacing),
                    if (controller.project.projectImages?.isNotEmpty == true)
                      _buildImageGallery(context),
                    SizedBox(height: context.verticalSpacing * 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.isMobile ? 200 : 250,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: controller.onBackPressed,
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                controller.project.bgColor.withOpacity(0.3),
                controller.project.bgColor.withOpacity(0.1),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: 'project_${controller.project.projectType}',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(controller.project.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.getStaggeredAnimation(0.1),
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.getStaggeredAnimation(0.1),
          child: SlideTransition(
            position: controller.getSlideAnimation(0.1),
            child: Container(
              width: double.infinity,
              padding: context.responsivePadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.project.title,
                    style: TextStyle(
                      fontSize: context.titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.project.subtitle,
                    style: TextStyle(
                      fontSize: context.subtitleFontSize,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (controller.project.description?.isNotEmpty == true) ...[
                    const SizedBox(height: 16),
                    Text(
                      controller.project.description!,
                      style: TextStyle(
                        fontSize: context.bodyFontSize,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectInfo(BuildContext context) {
    final sections = [
      if (controller.project.features?.isNotEmpty == true)
        _InfoSection(
          title: AppStrings.keyFeatures.tr,
          content: controller.project.features!,
          icon: Icons.star_outline,
          color: Colors.blue,
        ),
      if (controller.project.technologiesUsed?.isNotEmpty == true)
        _InfoSection(
          title: AppStrings.techStack.tr,
          content: controller.project.technologiesUsed!,
          icon: Icons.code,
          color: Colors.green,
        ),
      if (controller.project.challenges?.isNotEmpty == true)
        _InfoSection(
          title: AppStrings.projectChallenges.tr,
          content: controller.project.challenges!,
          icon: Icons.psychology,
          color: Colors.orange,
        ),
      if (controller.project.solution?.isNotEmpty == true)
        _InfoSection(
          title: AppStrings.projectSolution.tr,
          content: controller.project.solution!,
          icon: Icons.lightbulb_outline,
          color: Colors.purple,
        ),
    ];

    return AnimatedBuilder(
      animation: controller.getStaggeredAnimation(0.2),
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.getStaggeredAnimation(0.2),
          child: SlideTransition(
            position: controller.getSlideAnimation(0.2),
            child:
                context.isMobile
                    ? Column(
                      children:
                          sections
                              .asMap()
                              .entries
                              .map(
                                (entry) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        entry.key < sections.length - 1
                                            ? context.verticalSpacing
                                            : 0,
                                  ),
                                  child: _buildInfoCard(
                                    context,
                                    entry.value,
                                    entry.key * 0.05,
                                  ),
                                ),
                              )
                              .toList(),
                    )
                    : Wrap(
                      spacing: context.horizontalSpacing,
                      runSpacing: context.verticalSpacing,
                      children:
                          sections
                              .asMap()
                              .entries
                              .map(
                                (entry) => SizedBox(
                                  width:
                                      (context.screenWidth -
                                          context.responsivePadding.horizontal -
                                          context.horizontalSpacing) /
                                      (ProjectDetailExtension(context).isTablet
                                          ? 1
                                          : 2),
                                  child: _buildInfoCard(
                                    context,
                                    entry.value,
                                    entry.key * 0.05,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    _InfoSection section,
    double delay,
  ) {
    return AnimatedBuilder(
      animation: controller.getStaggeredAnimation(0.25 + delay),
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.getStaggeredAnimation(0.25 + delay),
          child: SlideTransition(
            position: controller.getSlideAnimation(0.25 + delay),
            child: Container(
              width: double.infinity,
              padding: context.responsivePadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: section.color.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: section.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          section.icon,
                          color: section.color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          section.title,
                          style: TextStyle(
                            fontSize: context.subtitleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildBulletPoints(context, section.content),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBulletPoints(BuildContext context, String content) {
    final points = content.bulletPoints;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          points.map((point) {
            final cleanPoint =
                point.startsWith('•') ? point.substring(1).trim() : point;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      cleanPoint,
                      style: TextStyle(
                        fontSize: context.bodyFontSize,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.getStaggeredAnimation(0.35),
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.getStaggeredAnimation(0.35),
          child: SlideTransition(
            position: controller.getSlideAnimation(0.35),
            child: Container(
              padding: context.responsivePadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child:
                  context.isMobile
                      ? Column(
                        children: [
                          _buildActionButton(
                            context,
                            AppStrings.downloadOnPlayStore.tr,
                            Icons.android,
                            Colors.green,
                            controller.onPlayStoreTap,
                          ),
                          const SizedBox(height: 12),
                          _buildActionButton(
                            context,
                            AppStrings.downloadOnAppStore.tr,
                            Icons.apple,
                            Colors.black87,
                            controller.onAppStoreTap,
                          ),
                          const SizedBox(height: 12),
                          _buildActionButton(
                            context,
                            AppStrings.viewProject.tr,
                            Icons.launch,
                            Colors.blue,
                            controller.onViewProjectTap,
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              context,
                              AppStrings.downloadOnPlayStore.tr,
                              Icons.android,
                              Colors.green,
                              controller.onPlayStoreTap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActionButton(
                              context,
                              AppStrings.downloadOnAppStore.tr,
                              Icons.apple,
                              Colors.black87,
                              controller.onAppStoreTap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActionButton(
                              context,
                              AppStrings.viewProject.tr,
                              Icons.launch,
                              Colors.blue,
                              controller.onViewProjectTap,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: context.bodyFontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    if (controller.project.projectImages?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: controller.getStaggeredAnimation(0.45),
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.getStaggeredAnimation(0.45),
          child: SlideTransition(
            position: controller.getSlideAnimation(0.45),
            child: Container(
              padding: context.responsivePadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.projectImages.tr,
                    style: TextStyle(
                      fontSize: context.subtitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.gridColumns,
                      crossAxisSpacing: context.horizontalSpacing,
                      mainAxisSpacing: context.verticalSpacing,
                      childAspectRatio: context.imageAspectRatio,
                    ),
                    itemCount: controller.project.projectImages!.length,
                    itemBuilder: (context, index) {
                      return _buildImageCard(context, index);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCard(BuildContext context, int index) {
    return Obx(() {
      final isSelected = controller.selectedImageIndex.value == index;
      return GestureDetector(
        onTap: () => controller.onImageTap(index),
        child: Hero(
          tag: 'image_${controller.project.projectType}_$index',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey[300]!,
                width: isSelected ? 3 : 1,
              ),
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]
                  : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                controller.project.projectImages![index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _InfoSection {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  _InfoSection({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });
}

class FullScreenImageViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                    (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: initialIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}