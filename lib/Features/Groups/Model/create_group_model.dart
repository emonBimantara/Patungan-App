class CreateGroupRequest {
  final String name;
  final String paymentInfo;

  CreateGroupRequest({
    required this.name,
    required this.paymentInfo
  });

  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'paymentInfo': paymentInfo
    };
  }
}

class CreateGroupResponse {
  final String status;
  final String id;
  final String name;
  final String createdAt;
  final String paymentInfo;
  final String createdById;

  CreateGroupResponse({
    required this.status,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.paymentInfo,
    required this.createdById,
  });

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    final group = json['data']['group'];

    return CreateGroupResponse(
      status: json['status'],
      id: group['id'],
      name: group['name'],
      createdAt: group['createdAt'],
      paymentInfo: group['paymentInfo'],
      createdById: group['createdById'],
    );
  }
}