class ResponseUser {
  bool? success;
  String? token;

  ResponseUser({this.success, this.token});

  factory ResponseUser.fromJson(Map<String, dynamic> json) {
    return ResponseUser(
      success: json['success'],
      token: json['token'],
    );
  }
}
