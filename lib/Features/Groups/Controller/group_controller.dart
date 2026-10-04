import 'package:get/get.dart';
import 'package:patungan/Features/Groups/Model/create_group_model.dart';
import 'package:patungan/Features/Groups/Model/group_detail_model.dart';
import 'package:patungan/Features/Groups/Model/group_model.dart';
import 'package:patungan/Features/Groups/Service/group_service.dart';

class GroupController extends GetxController {
  final GroupService groupService;

  GroupController({required this.groupService});

  final groups = <Group>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final groupDetail = Rxn<GroupDetail>();

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

  Future<CreateGroupResponse?> createGroup(
    String token,
    String name,
    String paymentInfo,
  ) async {
    errorMessage.value = '';
    isLoading.value = true;

    try {
      final request = CreateGroupRequest(name: name, paymentInfo: paymentInfo);
      final response = await groupService.createGroup(token, request);

      return response;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');

      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getGroupDetail(String token, String groupId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await groupService.getGroupDetail(token, groupId);

      groupDetail.value = result;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
