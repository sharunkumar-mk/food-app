UserModel userModelFromJson(str) {
  return UserModel.fromJson(str);
}

User userFromJson(str) {
  return User.fromJson(str);
}

class UserModel {
  List<User>? users;

  UserModel({this.users});

  factory UserModel.fromJson(List<dynamic>? json) {
    return UserModel(
      users: json != null
          ? List<User>.from(json.map((user) => User.fromJson(user)))
          : null,
    );
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? photo;

  User({this.id, this.name, this.email, this.address, this.phone, this.photo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    };
  }
}
