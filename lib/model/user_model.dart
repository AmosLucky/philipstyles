class UserModel {
  String? id, username, password, email, phoneNumber, address;
  UserModel(
      {this.id,
      this.username,
      this.email,
      this.phoneNumber,
      this.password,
      this.address});

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(
      id: user['id'],
      username: user['username'],
      password: user['password'],
      address: user['address'],
      phoneNumber: user['phone_number'],
      email: user['email'],
    );
  }
}
