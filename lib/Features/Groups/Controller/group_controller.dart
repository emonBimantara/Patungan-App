import 'package:get/get.dart';
import 'package:patungan/Features/Groups/Model/group_model.dart';
import 'package:patungan/Features/Groups/Service/group_service.dart';

class GroupController extends GetxController {
  final GroupService groupService;

  GroupController({required this.groupService});

  final groups = <Group>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> getMyGroups(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await groupService.getMyGroups(token);

      groups.value = result;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
