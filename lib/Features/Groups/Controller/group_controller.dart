import 'package:get/get.dart';
import 'package:patungan/Features/Groups/Model/add_member_model.dart';
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

  final isAddingMember = false.obs;
  final addMemberError = ''.obs;

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

  Future<bool> addMember(String token, String groupId, String email) async {
    isAddingMember.value = true;
    addMemberError.value = '';

    try {
      final request = AddMemberRequest(email: email);
      await groupService.addMember(token, groupId, request);

      return true;
    } catch (e) {
      final error = e.toString();

      if (error.contains('User not found')) {
        addMemberError.value = 'Invalid Email';
      } else if (error.contains('already a member')) {
        addMemberError.value = 'User is already a member';
      } else {
        addMemberError.value = 'Failed to add member';
      }

      return false;
    } finally {
      isAddingMember.value = false;
    }
  }
}
