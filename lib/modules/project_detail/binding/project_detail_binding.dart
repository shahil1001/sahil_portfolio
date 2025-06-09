import 'package:get/get.dart';
import 'package:portfolio_daman/modules/project_detail/controller/project_detail_controller.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(() => ProjectDetailController());
  }
}
