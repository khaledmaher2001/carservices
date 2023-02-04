class UserData {
  String? name;
  String? email;
  String? userId;
  String? phone;


  UserData({
    this.name,
    this.email,
    this.phone,
    this.userId,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    userId = json['userId'];
  }

  Map<String, dynamic> toMap() {
    return {

      'name': name,
      'email': email,
      'phone': phone,
      'userId': userId,
    };
  }
}