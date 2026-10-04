class AddMemberRequest {
  final String email;

  AddMemberRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
