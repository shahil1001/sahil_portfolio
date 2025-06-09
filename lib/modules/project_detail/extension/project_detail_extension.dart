import 'package:flutter/material.dart';

extension ProjectDetailExtension on BuildContext {
  // Screen size getters
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Responsive breakpoints
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  // Responsive padding
  EdgeInsets get responsivePadding {
    if (isMobile) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  // Responsive margins
  EdgeInsets get responsiveMargin {
    if (isMobile) {
      return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
    } else if (isTablet) {
      return const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0);
    }
  }

  // Responsive font sizes
  double get titleFontSize {
    if (isMobile) return 24.0;
    if (isTablet) return 28.0;
    return 32.0;
  }

  double get subtitleFontSize {
    if (isMobile) return 18.0;
    if (isTablet) return 20.0;
    return 22.0;
  }

  double get bodyFontSize {
    if (isMobile) return 14.0;
    if (isTablet) return 16.0;
    return 18.0;
  }

  // Responsive spacing
  double get verticalSpacing {
    if (isMobile) return 16.0;
    if (isTablet) return 24.0;
    return 32.0;
  }

  double get horizontalSpacing {
    if (isMobile) return 12.0;
    if (isTablet) return 16.0;
    return 20.0;
  }

  // Grid columns for responsive layout
  int get gridColumns {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 3;
  }

  // Max content width for better readability
  double get maxContentWidth {
    if (isMobile) return screenWidth;
    if (isTablet) return 800;
    return 1200;
  }

  // Button sizes
  Size get buttonSize {
    if (isMobile) return const Size(140, 45);
    if (isTablet) return const Size(160, 50);
    return const Size(180, 55);
  }

  // Image aspect ratios
  double get imageAspectRatio {
    if (isMobile) return 16 / 25;
    if (isTablet) return 4 / 3;
    return 16 / 10;
  }
}

extension StringExtension on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  List<String> get bulletPoints {
    return split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .toList();
  }
}
