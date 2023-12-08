class SetPasswordRequest {
  String? oldPassword;
  String? newPassword;
  String? newPasswordAgain;

  SetPasswordRequest(
      {this.oldPassword, this.newPassword, this.newPasswordAgain});

  SetPasswordRequest.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    newPasswordAgain = json['newPasswordAgain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    data['newPasswordAgain'] = newPasswordAgain;
    return data;
  }
}
