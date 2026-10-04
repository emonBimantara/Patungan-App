import 'package:get/get.dart';
import 'package:patungan/Features/Groups/Controller/group_controller.dart';
import 'package:patungan/Features/Groups/Service/group_service.dart';

class GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupService>(() => GroupService());

    Get.lazyPut<GroupController>(
      () => GroupController(groupService: Get.find<GroupService>()),
    );
  }
}
