class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? userName;
  String? profileImage;
  String? phone;
  String? address;
  String? gender;
  String? dateOfBirth;
  String? latitude;
  String? longitude;
  String? fcmToken;
  bool? notification;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.userName,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.latitude,
    this.longitude,
    this.fcmToken,
    this.notification = true,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      lastName: map['lastName'],
      firstName: map['firstName'],
      userName: map['userName'],
      email: map['email'],
      phone: map['phone'],
      profileImage: map['profileImage'],
      address: map['address'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      fcmToken: map['fcmToken'],
      notification: map['notification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastName': lastName,
      'firstName': firstName,
      'userName': userName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'fcmToken': fcmToken,
      'notification': notification,
    };
  }
}
