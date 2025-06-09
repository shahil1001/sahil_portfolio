import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_daman/modules/home/controller/home_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/image_resources.dart';
import 'dart:ui'; // Add this import for ImageFilter
import '../models/service_model.dart';
import '../models/testimonial_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Obx(
          () => _PortfolioAppBar(
            onNavTap: controller.scrollToSection,
            activeSection: controller.activeSection.value,
          ),
        ),
      ),
      drawer:
          MediaQuery.of(context).size.width < 900
              ? Obx(
                () => _PortfolioDrawer(
                  onNavTap: controller.scrollToSection,
                  activeSection: controller.activeSection.value,
                ),
              )
              : null,
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: [
            _SectionWrapper(
              key: controller.sectionKeys['home'],
              child: _HeroSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['stats'],
              child: _StatsSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['about'],
              child: _AboutSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['services'],
              child: _ServicesSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['projects'],
              child: _ProjectsSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['testimonials'],
              child: _TestimonialsSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['resume'],
              child: _ResumeSection(),
            ),
            // _SectionWrapper(
            //   key: controller.sectionKeys['skills'],
            //   child: _SkillsSection(),
            // ),
            _SectionWrapper(
              // key: controller.sectionKeys['skills2'],
              key: controller.sectionKeys['skills'],
              child: _AnimatedSkillCardsSection(),
            ),
            _SectionWrapper(
              key: controller.sectionKeys['contact'],
              child: _ContactSection(),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _SectionWrapper extends StatelessWidget {
  final Widget child;
  const _SectionWrapper({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(child: child);
}

class _PortfolioAppBar extends StatelessWidget {
  final void Function(String section)? onNavTap;
  final String? activeSection;
  const _PortfolioAppBar({this.onNavTap, this.activeSection});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final isTablet = MediaQuery.of(context).size.width < 1200;

    final navItems = [
      {'key': 'home', 'label': AppStrings.home},
      {'key': 'about', 'label': AppStrings.about},
      {'key': 'services', 'label': AppStrings.services},
      {'key': 'projects', 'label': AppStrings.projects},
      {'key': 'testimonials', 'label': AppStrings.testimonials},
      {'key': 'resume', 'label': AppStrings.resume},
      {'key': 'skills', 'label': AppStrings.skills},
      {'key': 'contact', 'label': AppStrings.contact},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: isMobile ? 0 : 32),
          child: Row(
            children: [
              Image.asset(ImageResources.appLogo, height: 45),
              if (!isMobile) ...[
                const SizedBox(width: 12),
                Text(
                  AppStrings.portfolio.tr,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          if (!isMobile)
            ...navItems.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextButton(
                  onPressed: () => onNavTap?.call(item['key']!),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    item['label']!.tr,
                    style: TextStyle(
                      color:
                          activeSection == item['key']
                              ? const Color(0xFFFF553E)
                              : Colors.black87,
                      fontWeight:
                          activeSection == item['key']
                              ? FontWeight.bold
                              : FontWeight.w600,
                      fontSize: 16,
                      // decoration:
                      //     activeSection == item['key']
                      //         ? TextDecoration.underline
                      //         : null,
                      decorationColor: const Color(0xFFFF553E),
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
            ),
          // if (!isMobile)
          //   Flexible(
          //     child: Padding(
          //       padding: EdgeInsets.only(right: isTablet ? 16 : 48, left: 16),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           if (Get.isRegistered<HomeController>()) {
          //             Get.find<HomeController>().onClickDownloadCv();
          //           }
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color(0xFFFF553E),
          //           foregroundColor: Colors.white,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 28,
          //             vertical: 14,
          //           ),
          //           elevation: 6,
          //           shadowColor: const Color(0xFFFF553E).withOpacity(0.3),
          //         ),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Icon(Icons.download, size: 18),
          //             const SizedBox(width: 8),
          //             Flexible(
          //               child: Text(
          //                 AppStrings.downloadCV.tr,
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 15,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
    );
  }
}

class _PortfolioDrawer extends StatelessWidget {
  final void Function(String section)? onNavTap;
  final String? activeSection;
  const _PortfolioDrawer({this.onNavTap, this.activeSection});

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'key': 'home', 'label': AppStrings.home},
      {'key': 'about', 'label': AppStrings.about},
      {'key': 'services', 'label': AppStrings.services},
      {'key': 'projects', 'label': AppStrings.projects},
      {'key': 'testimonials', 'label': AppStrings.testimonials},
      {'key': 'resume', 'label': AppStrings.resume},
      {'key': 'skills', 'label': AppStrings.skills},
      {'key': 'contact', 'label': AppStrings.contact},
    ];

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Image.asset(ImageResources.appLogo, height: 50),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.portfolio.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children:
                      navItems
                          .map(
                            (item) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    activeSection == item['key']
                                        ? const Color(
                                          0xFFFF553E,
                                        ).withOpacity(0.1)
                                        : null,
                              ),
                              child: ListTile(
                                title: Text(
                                  item['label']!.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color:
                                        activeSection == item['key']
                                            ? const Color(0xFFFF553E)
                                            : Colors.black87,
                                  ),
                                ),
                                onTap: () {
                                  onNavTap?.call(item['key']!);
                                  Navigator.pop(context);
                                },
                                leading: Icon(
                                  _getIconForSection(item['key']!),
                                  color:
                                      activeSection == item['key']
                                          ? const Color(0xFFFF553E)
                                          : Colors.black54,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       if (Get.isRegistered<HomeController>()) {
              //         Get.find<HomeController>().onClickDownloadCv();
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFFFF553E),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       elevation: 6,
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.download, color: Colors.white),
              //         const SizedBox(width: 8),
              //         Text(
              //           AppStrings.downloadCV.tr,
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForSection(String section) {
    switch (section) {
      case 'home':
        return Icons.home;
      case 'about':
        return Icons.person;
      case 'services':
        return Icons.business_center;
      case 'projects':
        return Icons.work;
      case 'testimonials':
        return Icons.star;
      case 'resume':
        return Icons.description;
      case 'skills':
        return Icons.code;
      case 'contact':
        return Icons.contact_mail;
      default:
        return Icons.circle;
    }
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 700 : MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.orange.shade50,
            Colors.pink.shade50,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 40 : 80,
            ),
            child: isMobile ? _MobileHeroSection() : _DesktopHeroSection(),
          ),
        ),
      ),
    );
  }
}

class _DesktopHeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1400;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFFFF553E).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  AppStrings.helloIm.tr,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 20 : 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF553E),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.developerName.tr,
                style: TextStyle(
                  fontSize: isLargeScreen ? 64 : 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.developerTitle.tr,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 48 : 40,
                      fontWeight: FontWeight.bold,
                      foreground:
                          Paint()
                            ..shader = const LinearGradient(
                              colors: [Color(0xFFFF553E), Color(0xFFFFA726)],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(ImageResources.arrowIcon, height: 40),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: isLargeScreen ? 600 : 520,
                child: Text(
                  AppStrings.developerDescription.tr,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: isLargeScreen ? 18 : 16,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         if (Get.isRegistered<HomeController>()) {
                  //           Get.find<HomeController>().onClickDownloadCv();
                  //         }
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: const Color(0xFFFF553E),
                  //         foregroundColor: Colors.white,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30),
                  //         ),
                  //         padding: EdgeInsets.symmetric(
                  //           horizontal: isLargeScreen ? 40 : 32,
                  //           vertical: isLargeScreen ? 20 : 16,
                  //         ),
                  //         elevation: 8,
                  //         shadowColor: const Color(0xFFFF553E).withOpacity(0.4),
                  //       ),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Icon(Icons.download, size: isLargeScreen ? 24 : 20),
                  //           const SizedBox(width: 12),
                  //           Text(
                  //             AppStrings.downloadCV.tr,
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: isLargeScreen ? 18 : 16,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     const SizedBox(width: 24),
                  OutlinedButton(
                    onPressed: () {
                      if (Get.isRegistered<HomeController>()) {
                        Get.find<HomeController>().onClickViewWork();
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFFF553E),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 40 : 32,
                        vertical: isLargeScreen ? 20 : 16,
                      ),
                    ),
                    child: Text(
                      AppStrings.viewWork.tr,
                      style: TextStyle(
                        color: const Color(0xFFFF553E),
                        fontWeight: FontWeight.bold,
                        fontSize: isLargeScreen ? 18 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            height: 500,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Floating icons with improved positioning
                Positioned(
                  top: 20,
                  left: 80,
                  child: _FloatingIcon(ImageResources.flutterIcon, 0),
                ),
                Positioned(
                  top: 210,
                  left: 20,
                  child: _FloatingIcon(ImageResources.mobileCodingIcon, 1),
                ),
                Positioned(
                  top: 210,
                  right: 20,
                  child: _FloatingIcon(ImageResources.androidIcon, 2),
                ),
                Positioned(
                  top: 10,
                  right: 80,
                  child: _FloatingIcon(ImageResources.mobileCodingIcon, 3),
                ),
                // Main profile image with enhanced styling
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF553E).withOpacity(0.3),
                        const Color(0xFFFFA726).withOpacity(0.3),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF553E).withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 136,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 130,
                        backgroundImage: AssetImage(
                          ImageResources.profileImage,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingIcon extends StatefulWidget {
  final String iconPath;
  final int index;

  const _FloatingIcon(this.iconPath, this.index);

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3 + widget.index),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * _controller.value),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(widget.iconPath, height: 80),
          ),
        );
      },
    );
  }
}

class _MobileHeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFFFF553E).withOpacity(0.3)),
          ),
          child: Text(
            AppStrings.helloIm.tr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF553E),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.developerName.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth < 400 ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.developerTitle.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth < 400 ? 24 : 28,
            fontWeight: FontWeight.bold,
            foreground:
                Paint()
                  ..shader = const LinearGradient(
                    colors: [Color(0xFFFF553E), Color(0xFFFFA726)],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 50.0)),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.developerDescription.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            //     SizedBox(
            //       width: double.infinity,
            //       child: ElevatedButton(
            //         onPressed: () {
            //           if (Get.isRegistered<HomeController>()) {
            //             Get.find<HomeController>().onClickDownloadCv();
            //           }
            //         },
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: const Color(0xFFFF553E),
            //           foregroundColor: Colors.white,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30),
            //           ),
            //           padding: const EdgeInsets.symmetric(vertical: 16),
            //           elevation: 8,
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Icon(Icons.download),
            //             const SizedBox(width: 8),
            //             Text(
            //               AppStrings.downloadCV.tr,
            //               style: const TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (Get.isRegistered<HomeController>()) {
                    Get.find<HomeController>().onClickViewWork();
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF553E), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  AppStrings.viewWork.tr,
                  style: TextStyle(
                    color: const Color(0xFFFF553E),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 60,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(ImageResources.flutterIcon, height: 50),
                ),
              ),
              Positioned(
                top: 80,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    ImageResources.mobileCodingIcon,
                    height: 50,
                  ),
                ),
              ),
              Positioned(
                top: 80,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(ImageResources.androidIcon, height: 50),
                ),
              ),
              Positioned(
                top: 0,
                right: 60,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    ImageResources.mobileCodingIcon,
                    height: 50,
                  ),
                ),
              ),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF553E).withOpacity(0.3),
                      const Color(0xFFFFA726).withOpacity(0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    radius: 77,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 72,
                      backgroundImage: AssetImage(ImageResources.profileImage),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8F9FA),
            Colors.blue.shade50,
            const Color(0xFFE3F0FF),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: isMobile ? _MobileStatsGrid() : _DesktopStatsGrid(),
          ),
        ),
      ),
    );
  }
}

class _DesktopStatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _StatCard('3', AppStrings.yearsExperience.tr, Icons.timeline),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _StatCard('5', AppStrings.projectsCompleted.tr, Icons.work),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _StatCard(
            '5',
            AppStrings.happyClients.tr,
            Icons.sentiment_satisfied,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(child: _StatCard('5', AppStrings.bestRatings.tr, Icons.star)),
      ],
    );
  }
}

class _MobileStatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                '3',
                AppStrings.yearsExperience.tr,
                Icons.timeline,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                '5',
                AppStrings.projectsCompleted.tr,
                Icons.work,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                '5',
                AppStrings.happyClients.tr,
                Icons.sentiment_satisfied,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard('5', AppStrings.bestRatings.tr, Icons.star),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;

  const _StatCard(this.number, this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF553E).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFFF553E), size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            number,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFF553E),
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: isMobile ? _MobileAboutContent() : _DesktopAboutContent(),
          ),
        ),
      ),
    );
  }
}

class _DesktopAboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1400;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFF553E).withOpacity(0.1),
                  const Color(0xFFFFA726).withOpacity(0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  ImageResources.transparentProfileImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF553E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFFFF553E).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  AppStrings.portfolio.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF553E),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.aboutMe.tr,
                style: TextStyle(
                  fontSize: isLargeScreen ? 48 : 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                AppStrings.aboutDescription.tr,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: isLargeScreen ? 18 : 16,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              // Row(
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         if (Get.isRegistered<HomeController>()) {
              //           Get.find<HomeController>().onClickDownloadCv();
              //         }
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: const Color(0xFFFF553E),
              //         foregroundColor: Colors.white,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         padding: EdgeInsets.symmetric(
              //           horizontal: isLargeScreen ? 40 : 32,
              //           vertical: isLargeScreen ? 20 : 16,
              //         ),
              //         elevation: 8,
              //         shadowColor: const Color(0xFFFF553E).withOpacity(0.4),
              //       ),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Icon(Icons.download, size: isLargeScreen ? 22 : 20),
              //           const SizedBox(width: 12),
              //           Text(
              //             AppStrings.downloadCV.tr,
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: isLargeScreen ? 18 : 16,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 24),
              //     OutlinedButton(
              //       onPressed: () {
              //         if (Get.isRegistered<HomeController>()) {
              //           Get.find<HomeController>().onClickGetInTouch();
              //         }
              //       },
              //       style: OutlinedButton.styleFrom(
              //         side: const BorderSide(
              //           color: Color(0xFFFF553E),
              //           width: 2,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         padding: EdgeInsets.symmetric(
              //           horizontal: isLargeScreen ? 40 : 32,
              //           vertical: isLargeScreen ? 20 : 16,
              //         ),
              //       ),
              //       child: Text(
              //         AppStrings.getInTouch.tr,
              //         style: TextStyle(
              //           color: const Color(0xFFFF553E),
              //           fontWeight: FontWeight.bold,
              //           fontSize: isLargeScreen ? 18 : 16,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileAboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFF553E).withOpacity(0.1),
                const Color(0xFFFFA726).withOpacity(0.1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                ImageResources.transparentProfileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF553E).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFFFF553E).withOpacity(0.3)),
          ),
          child: Text(
            AppStrings.portfolio.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFF553E),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.aboutMe.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth < 400 ? 28 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Text(
        //     AppStrings.aboutDescription.tr,
        //     textAlign: TextAlign.center,
        //     style: const TextStyle(
        //       color: Colors.black87,
        //       fontSize: 16,
        //       height: 1.7,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 32),
        // Column(
        //   children: [
        //     SizedBox(
        //       width: double.infinity,
        //       child: ElevatedButton(
        //         onPressed: () {
        //           if (Get.isRegistered<HomeController>()) {
        //             Get.find<HomeController>().onClickDownloadCv();
        //           }
        //         },
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: const Color(0xFFFF553E),
        //           foregroundColor: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           padding: const EdgeInsets.symmetric(vertical: 16),
        //           elevation: 8,
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             const Icon(Icons.download),
        //             const SizedBox(width: 8),
        //             Text(
        //               AppStrings.downloadCV.tr,
        //               style: const TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 16,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     const SizedBox(height: 16),
        //     SizedBox(
        //       width: double.infinity,
        //       child: OutlinedButton(
        //         onPressed: () {
        //           if (Get.isRegistered<HomeController>()) {
        //             Get.find<HomeController>().onClickGetInTouch();
        //           }
        //         },
        //         style: OutlinedButton.styleFrom(
        //           side: const BorderSide(color: Color(0xFFFF553E), width: 2),
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           padding: const EdgeInsets.symmetric(vertical: 16),
        //         ),
        //         child: Text(
        //           AppStrings.getInTouch.tr,
        //           style: TextStyle(
        //             color: const Color(0xFFFF553E),
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8F9FA),
            Colors.blue.shade50,
            const Color(0xFFE3F0FF),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF553E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    AppStrings.portfolio.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF553E),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.myServices.tr,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    AppStrings.servicesDescription.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 0.9 : 0.85,
                  ),
                  itemCount: servicesList.length,
                  itemBuilder: (context, index) {
                    final service = servicesList[index];
                    return _ServiceCard(
                      service.imagePath,
                      service.title,
                      service.description,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;

  const _ServiceCard(this.imagePath, this.title, this.description);

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform:
            Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.15 : 0.08),
              blurRadius: isHovered ? 25 : 20,
              offset: Offset(0, isHovered ? 15 : 10),
            ),
          ],
          border: Border.all(
            color:
                isHovered
                    ? const Color(0xFFFF553E).withOpacity(0.3)
                    : Colors.grey.shade100,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFFF553E).withOpacity(0.1),
                      const Color(0xFFFFA726).withOpacity(0.1),
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF553E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    AppStrings.portfolio.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF553E),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.projectsSectionTitle.tr,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    AppStrings.projectsSectionDesc.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 0.7 : 0.75,
                  ),
                  itemCount: projectsList.length,
                  itemBuilder: (context, index) {
                    final project = projectsList[index];
                    return _ProjectCard(
                      project,
                      project.imagePath,
                      project.title,
                      project.subtitle,
                      project.bgColor,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final String imagePath;
  final String title;
  final String subtitle;
  final Color bgColor;

  const _ProjectCard(
    this.project,
    this.imagePath,
    this.title,
    this.subtitle,
    this.bgColor,
  );

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform:
            Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.15 : 0.08),
              blurRadius: isHovered ? 25 : 20,
              offset: Offset(0, isHovered ? 15 : 10),
            ),
          ],
          border: Border.all(
            color:
                isHovered
                    ? const Color(0xFFFF553E).withOpacity(0.3)
                    : Colors.grey.shade100,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.subtitle,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isHovered ? 120 : 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (Get.isRegistered<HomeController>()) {
                    Get.find<HomeController>().onClickProjectView(
                      project: widget.project,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF553E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: isHovered ? 8 : 4,
                  shadowColor: const Color(0xFFFF553E).withOpacity(0.3),
                ),
                child: Text(
                  AppStrings.view.tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;
    final crossAxisCount = isMobile ? 1 : 2;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8F9FA),
            Colors.blue.shade50,
            const Color(0xFFE3F0FF),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF553E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    AppStrings.portfolio.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF553E),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.testimonialsSectionTitle.tr,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    AppStrings.testimonialsSectionDesc.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 0.85 : 1.4,
                  ),
                  itemCount: testimonialsList.length,
                  itemBuilder: (context, index) {
                    final testimonial = testimonialsList[index];
                    return _TestimonialCard(
                      testimonial.imagePath,
                      testimonial.name,
                      testimonial.role,
                      testimonial.quote,
                      testimonial.bgColor,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String role;
  final String quote;
  final Color bgColor;

  const _TestimonialCard(
    this.imagePath,
    this.name,
    this.role,
    this.quote,
    this.bgColor,
  );

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform:
            Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.15 : 0.08),
              blurRadius: isHovered ? 25 : 20,
              offset: Offset(0, isHovered ? 15 : 10),
            ),
          ],
          border: Border.all(
            color:
                isHovered
                    ? const Color(0xFFFF553E).withOpacity(0.3)
                    : Colors.grey.shade100,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF553E).withOpacity(0.3),
                      const Color(0xFFFFA726).withOpacity(0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF553E).withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.imagePath),
                  radius: 45,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.role,
                style: TextStyle(
                  color: const Color(0xFFFF553E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.bgColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: const Color(0xFFFF553E),
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.quote,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF553E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    AppStrings.portfolio.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF553E),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.resumeSectionTitle.tr,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    AppStrings.resumeSectionDesc.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                isMobile
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ResumeExperienceColumn(),
                        const SizedBox(height: 48),
                        _ResumeEducationColumn(),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _ResumeExperienceColumn()),
                        const SizedBox(width: 64),
                        Expanded(child: _ResumeEducationColumn()),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeExperienceColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF553E).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.work, color: const Color(0xFFFF553E), size: 28),
            ),
            const SizedBox(width: 16),
            Text(
              AppStrings.workingExperience.tr,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _ResumeExperienceItem(
          role: AppStrings.resumeExp1Role.tr,
          company: AppStrings.resumeExp1Company.tr,
          companyColor: Colors.redAccent,
          desc: AppStrings.resumeExp1Desc.tr,
        ),
        const SizedBox(height: 40),
        _ResumeExperienceItem(
          role: AppStrings.resumeExp2Role.tr,
          company: AppStrings.resumeExp2Company.tr,
          companyColor: Colors.redAccent,
          desc: AppStrings.resumeExp2Desc.tr,
        ),
        const SizedBox(height: 40),
        _ResumeExperienceItem(
          role: AppStrings.resumeExp3Role.tr,
          company: AppStrings.resumeExp3Company.tr,
          companyColor: Colors.redAccent,
          desc: AppStrings.resumeExp3Desc.tr,
        ),
      ],
    );
  }
}

class _ResumeExperienceItem extends StatefulWidget {
  final String role, company, desc;
  final Color companyColor;

  const _ResumeExperienceItem({
    required this.role,
    required this.company,
    required this.desc,
    required this.companyColor,
  });

  @override
  State<_ResumeExperienceItem> createState() => _ResumeExperienceItemState();
}

class _ResumeExperienceItemState extends State<_ResumeExperienceItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.12 : 0.06),
              blurRadius: isHovered ? 20 : 15,
              offset: Offset(0, isHovered ? 10 : 5),
            ),
          ],
          border: Border.all(
            color:
                isHovered
                    ? const Color(0xFFFF553E).withOpacity(0.3)
                    : Colors.grey.shade100,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.role,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.company,
              style: TextStyle(
                color: const Color(0xFFFF553E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.desc,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumeEducationColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF553E).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school,
                color: const Color(0xFFFF553E),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              AppStrings.educationLearning.tr,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _ResumeEducationItem(
          degree: AppStrings.resumeEdu1Degree.tr,
          school: AppStrings.resumeEdu1School.tr,
          schoolColor: Colors.redAccent,
          desc: AppStrings.resumeEdu1Desc.tr,
        ),
        const SizedBox(height: 40),
        _ResumeEducationItem(
          degree: AppStrings.resumeEdu2Degree.tr,
          school: AppStrings.resumeEdu2School.tr,
          schoolColor: Colors.redAccent,
          desc: AppStrings.resumeEdu2Desc.tr,
        ),
      ],
    );
  }
}

class _ResumeEducationItem extends StatefulWidget {
  final String degree, school, desc;
  final Color schoolColor;

  const _ResumeEducationItem({
    required this.degree,
    required this.school,
    required this.desc,
    required this.schoolColor,
  });

  @override
  State<_ResumeEducationItem> createState() => _ResumeEducationItemState();
}

class _ResumeEducationItemState extends State<_ResumeEducationItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.12 : 0.06),
              blurRadius: isHovered ? 20 : 15,
              offset: Offset(0, isHovered ? 10 : 5),
            ),
          ],
          border: Border.all(
            color:
                isHovered
                    ? const Color(0xFFFF553E).withOpacity(0.3)
                    : Colors.grey.shade100,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.degree,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.school,
              style: TextStyle(
                color: const Color(0xFFFF553E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.desc,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;
    final crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFCF8F3),
            Colors.orange.shade50,
            const Color(0xFFF8F9FA),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF553E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    AppStrings.portfolio.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF553E),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.skillsSectionTitle.tr,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    AppStrings.skillsSectionDesc.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 40,
                        childAspectRatio: isMobile ? 0.6 : 0.95,
                      ),
                      itemCount: skills.length,
                      itemBuilder: (context, index) {
                        return _AnimatedSkillRadial(
                          skillName: skills[index].name.tr,
                          iconData: skills[index].icon,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedSkillRadial extends StatefulWidget {
  final String skillName;
  final IconData iconData;
  const _AnimatedSkillRadial({required this.skillName, required this.iconData});

  @override
  State<_AnimatedSkillRadial> createState() => _AnimatedSkillRadialState();
}

class _AnimatedSkillRadialState extends State<_AnimatedSkillRadial>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
            Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _RadialPainter(_animation.value),
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                isHovered ? 0.15 : 0.07,
                              ),
                              blurRadius: isHovered ? 15 : 8,
                              offset: Offset(0, isHovered ? 8 : 4),
                            ),
                          ],
                          border: Border.all(
                            color:
                                isHovered
                                    ? const Color(0xFFFF553E).withOpacity(0.3)
                                    : Colors.grey.shade100,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          widget.iconData,
                          size: 42,
                          color: const Color(0xFFFF553E),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.skillName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  _RadialPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      startAngle: -1.57,
      endAngle: 4.71,
      colors: [
        const Color(0xFFFF553E),
        const Color(0xFFFFA726),
        const Color(0xFFFF553E),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
    final backgroundPaint =
        Paint()
          ..color = Colors.black12
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8;
    final foregroundPaint =
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 8;
    // Draw background circle
    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2 - 4,
      backgroundPaint,
    );
    // Draw animated arc
    final angle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: size.width / 2 - 4,
      ),
      -1.57,
      angle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RadialPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _AnimatedSkillCardsSection extends StatefulWidget {
  @override
  State<_AnimatedSkillCardsSection> createState() =>
      _AnimatedSkillCardsSectionState();
}

class _AnimatedSkillCardsSectionState extends State<_AnimatedSkillCardsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth < 1200;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1400,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF553E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFF553E).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    AppStrings.portfolio.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF553E),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.skillCardsSectionTitle.tr,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    AppStrings.skillCardsSectionDesc.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32,
                        childAspectRatio: isMobile ? 1.2 : 1.3,
                      ),
                      itemCount: skillCards.length,
                      itemBuilder: (context, index) {
                        final animation = Tween<Offset>(
                          begin: Offset(0, 0.2 + 0.1 * (index % 3)),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: Interval(
                              0.05 * index,
                              0.5 + 0.05 * index,
                              curve: Curves.easeOut,
                            ),
                          ),
                        );
                        final fade = CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            0.05 * index,
                            0.5 + 0.05 * index,
                            curve: Curves.easeIn,
                          ),
                        );
                        return SlideTransition(
                          position: animation,
                          child: FadeTransition(
                            opacity: fade,
                            child: _SkillCard(
                              icon: skillCards[index].icon,
                              title: skillCards[index].title.tr,
                              desc: skillCards[index].desc.tr,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _SkillCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform:
            Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0, 0.0),
        child: Material(
          color: Colors.white,
          elevation: isHovered ? 12 : 6,
          borderRadius: BorderRadius.circular(24),
          shadowColor: Colors.black.withOpacity(0.1),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color:
                      isHovered
                          ? const Color(0xFFFF553E).withOpacity(0.3)
                          : Colors.grey.shade100,
                  width: isHovered ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF553E),
                          const Color(0xFFFFA726),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF553E).withOpacity(0.3),
                          blurRadius: isHovered ? 20 : 15,
                          offset: Offset(0, isHovered ? 8 : 4),
                        ),
                      ],
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.desc,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 0,
        vertical: isMobile ? 32 : 64,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F0FF), Color(0xFFF8F9FA), Color(0xFFD7F5E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.contactSectionTitle.tr,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 700,
                child: Text(
                  AppStrings.contactSectionDesc.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              isMobile
                  ? Column(
                    children: [
                      _ContactInfoCard(),
                      const SizedBox(height: 32),
                      _ContactFormCard(),
                    ],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _ContactInfoCard()),
                      const SizedBox(width: 32),
                      Expanded(child: _ContactFormCard()),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.contactInfoTitle.tr,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.contactInfoDesc.tr,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _ContactInfoItem(
            icon: Icons.phone,
            label: AppStrings.contactPhone.tr,
            value: AppStrings.contactInfoPhoneValue.tr,
          ),
          const SizedBox(height: 24),
          _ContactInfoItem(
            icon: Icons.email,
            label: AppStrings.contactEmail.tr,
            value: AppStrings.contactInfoEmailValue.tr,
          ),
          const SizedBox(height: 24),
          _ContactInfoItem(
            icon: Icons.location_on,
            label: AppStrings.contactAddress.tr,
            value: AppStrings.contactInfoAddressValue.tr,
          ),
        ],
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: const BoxDecoration(
            color: Color(0xFF44474D),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFFFF553E), size: 30),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactFormCard extends StatefulWidget {
  @override
  State<_ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<_ContactFormCard> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', message = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.contactFormTitle.tr,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppStrings.contactFormName.tr,
                hintText: AppStrings.contactFormNameHint.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator:
                  (v) =>
                      v == null || v.trim().isEmpty
                          ? AppStrings.contactFormNameHint.tr
                          : null,
              onSaved: (v) => name = v ?? '',
            ),
            const SizedBox(height: 20),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: AppStrings.contactFormEmail.tr,
            //     hintText: AppStrings.contactFormEmailHint.tr,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            //   validator: (v) {
            //     if (v == null || v.trim().isEmpty) {
            //       return AppStrings.contactFormEmailHint.tr;
            //     }
            //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            //     if (!emailRegex.hasMatch(v.trim())) {
            //       return AppStrings.contactFormEmailHint.tr;
            //     }
            //     return null;
            //   },
            //   onSaved: (v) => email = v ?? '',
            //   keyboardType: TextInputType.emailAddress,
            // ),
            // const SizedBox(height: 20),
            TextFormField(
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: AppStrings.contactFormMessage.tr,
                hintText: AppStrings.contactFormMessageHint.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator:
                  (v) =>
                      v == null || v.trim().isEmpty
                          ? AppStrings.contactFormMessageHint.tr
                          : null,
              onSaved: (v) => message = v ?? '',
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    _formKey.currentState?.reset();
                    if (Get.isRegistered<HomeController>()) {
                      Get.find<HomeController>().onClickSendMessage(
                        name: name,
                        email: email,
                        message: message,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF553E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: Text(
                  AppStrings.contactFormButton.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 16),
      color: const Color(0xFF222328),
      child: Center(
        child: Text(
          AppStrings.footerCopyright.tr,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
