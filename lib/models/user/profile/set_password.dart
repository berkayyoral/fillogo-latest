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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['newPasswordAgain'] = this.newPasswordAgain;
    return data;
  }
}
