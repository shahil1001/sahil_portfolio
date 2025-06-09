import 'package:get/get.dart';
import 'package:portfolio_daman/modules/home/binding/home_binding.dart';
import 'package:portfolio_daman/modules/project_detail/binding/project_detail_binding.dart';
import 'package:portfolio_daman/modules/project_detail/screen/project_detail_view.dart';
import '../modules/home/screen/home_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.projectDetail,
      page: () => const ProjectDetailView(),
      binding: ProjectDetailBinding(),
    ),
    // Add other routes here
  ];
}
