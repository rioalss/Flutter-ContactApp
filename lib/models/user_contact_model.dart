class UserContactModel {
  int? id;
  String email;
  String firstName;
  String lastName;
  String avatar;
  bool? isFavorite;

  UserContactModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.isFavorite});

  factory UserContactModel.fromJson(Map<String, dynamic> json) {
    return UserContactModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      isFavorite: json['isFavorite'],
    );
  }
}

List<UserContactModel> listUserModel = <UserContactModel>[];
